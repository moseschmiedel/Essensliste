package Essensliste::Controller::Users;
use Mojo::Base qw(Mojolicious::Controller);
use Data::Dump 'dump';

sub detail {
	my $self = shift;
	my $user = $self->db->resultset('User')->find($self->param('id'));

	my @meals = $user->meals->all;
	@meals = map { {
			id => $_->id,
			date => $_->date,
			comment => $_->comment,
			meal_url => $self->url_for('meal', id => $_->id)->to_abs,
		} } @meals;
	
	my %user = (
			name => $user->display_name,
			meals => \@meals,
		);
	
	$self->stash(user => \%user);
}

1;
