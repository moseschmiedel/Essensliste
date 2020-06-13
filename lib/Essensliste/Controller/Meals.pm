package Essensliste::Controller::Meals;
use Mojo::Base 'Mojolicious::Controller';
use Data::Dump 'dump';

sub list {
	my $self = shift;

	my @meals = $self->db->resultset("Meal")->all;


	@meals = map { {
			id => $_->id,
			date => $_->date,
			comment => $_->comment,
			user => defined $_->user ? $_->user->display_name : '',
			meal_url => $self->url_for('meal', id => $_->id)->to_abs,
			user_url => defined $_->user ? $self->url_for('user', id => $_->user->id)->to_abs : '',
		} } @meals;

	$self->stash(meals => \@meals);
}

sub detail {
	my $self = shift;

	my $meal = $self->db->resultset("Meal")->find($self->stash('id')) || undef;

	if (defined $meal) {
		$self->stash(
				id => $meal->id,
				date => $meal->date,
				comment => $meal->comment,
				user => defined $meal->user ? $meal->user->display_name : 'niemand',
				user_url => defined $meal->user ? $self->url_for('user', id => $meal->user->id)->to_abs : undef,
		);
	} else {
		$self->render('not_found');
	}
}

sub assign {
	my $self = shift;

	my $display_name = $self->param('name');
	my $user_name = lc $display_name;
	my $meal_id = $self->param('meal');

	say $user_name;
	my $meal = $self->db->resultset("Meal")->find($meal_id);
	my $user = $self->db->resultset("User")->find({name_lc => $user_name});

	if (defined $user && defined $meal) {
		$meal->update( {user_id => $user->id} );
	} elsif (defined $meal) {
		$self->db->txn_do(sub {
				$user = $self->db->resultset("User")->create({
						display_name => $display_name,
						name_lc => $user_name,
					});
				$meal->update( {user_id => $user->id} );
			});
	}

	$self->redirect_to('index');
}

1;
