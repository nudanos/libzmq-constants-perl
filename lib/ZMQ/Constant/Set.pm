package ZMQ::Constant::Set;
use strict;
use warnings;

sub new {
    my ( $class, %args ) = @_;
    return bless {%args}, $class;
}

sub match {
    my ( $self, $key ) = @_;
    return $self->{matcher}->($key);
}

sub get_tags {
    my ($self) = @_;
    my $t = $self->{tags} || {};
    return wantarray ? %$t : $t;
}

sub get_export_oks {
    my ($self) = @_;
    my $t = $self->get_tags;
    local $t->{all} = undef;
    delete $t->{all};
    my %u = map { ( $_ => 1 ) } map { @$_ } values %$t;
    my $l = [ keys %u ];
    return wantarray ? @$l : $l;
}

sub get_exports {
    my ($self) = @_;
    my $l = $self->{exports} || [];
    return wantarray ? @$l : $l;
}

1;

__END__

=head1 NAME

ZMQ::Constant::Set - one libzmq version's constants, for ZMQ::Constants

=head1 METHODS

=head2 new(matcher => $code, tags => \%tags, exports => \@names)

=head2 match($version)

True when this set is the one for $version.

=head2 get_tags

=head2 get_export_oks

=head2 get_exports

=cut
