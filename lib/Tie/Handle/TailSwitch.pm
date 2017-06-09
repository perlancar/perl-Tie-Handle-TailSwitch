package Tie::Handle::TailSwitch;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

sub TIEHANDLE {
    require Logfile::Tail::Switch;

    my ($class, %args) = @_;

    bless {
        tail => Logfile::Tail::Switch->new(%args),
    }, $class;
}

sub READLINE {
    my $self = shift;
    $self->{tail}->getline;
}

1;
# ABSTRACT: Tie to Logfile::Tail::Switch

=head1 SYNOPSIS

 use Time::HiRes 'sleep'; # for subsecond sleep
 use Tie::Handle::TailSwitch;
 tie *FH, 'Tie::Handle::TailSwitch',
     globs => ['/var/log/http_*', '/var/log/https_*'],
     # other Logfile::Tail::Switch options;

 while (1) {
     my $line = <FH>;
     if (length $line) {
         print $line;
     } else {
         sleep 0.1;
     }
 }


=head1 DESCRIPTION

This module ties a filehandle to L<Logfile::Tail::Switch> object.


=head1 METHODS

=head2 TIEHANDLE classname, LIST

Tie this package to file handle. C<LIST> will be passed to
L<Logfile::Tail::Switch>'s constructor.

=head2 READLINE this


=head1 SEE ALSO

L<Logfile::Tail::Switch>

=cut
