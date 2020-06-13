package Essensliste;
use Mojo::Base 'Mojolicious';
use Essensliste::Schema;

# This method will run once at server start
sub startup {
  my $self = shift;

  # Load configuration from hash returned by config file
  my $config = $self->plugin('Config');

  # Configure the application
  $self->secrets($config->{secrets});

  # Connect to database
  my $schema = Essensliste::Schema->connect('dbi:SQLite:essensliste.sqlite', undef, undef, {sqlite_unicode => 1});
  $self->helper(db => sub { return $schema; });

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('meals#list')->name('index');
  $r->get('/meal/:id' => [id => qr/\d+/])->to('meals#detail')->name('meal');
  $r->post('/meal/assign')->to('meals#assign')->name('assign');
  $r->get('/user/:id' => [id => qr/\d+/])->to('users#detail')->name('user');
}

1;
