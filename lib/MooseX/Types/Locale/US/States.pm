package MooseX::Types::Locale::US::States;
use 5.008;
use strict;
use warnings;
use namespace::autoclean;

our $VERSION = 'v0.1.0'; # VERSION

use MooseX::Types -declare => [ qw( USStateName USStateCode ) ];
use MooseX::Types::Moose qw( Str );

use Locale::US;

my $u = Locale::US->new;

enum USStateName,
	[ $u->all_state_names ]
	;

enum USStateCode,
	[ $u->all_state_codes ]
	;

coerce USStateName,
	from USStateCode,
	via {
		return $u->{code2state}{$_};
	}
	;

coerce USStateName,
	from Str,
	via {
		uc( $_ );
	}
	;

coerce USStateCode,
	from USStateName,
	via {
		return $u->{state2code}{$_};
	}
	;

coerce USStateCode,
	from Str,
	via {
		my $i = uc( $_ );
		return $u->{state2code}{$i};
	}
	;

1;

# ABSTRACT: MooseX::Types::Locale::US::States

__END__
=pod

=head1 NAME

MooseX::Types::Locale::US::States - MooseX::Types::Locale::US::States

=head1 VERSION

version v0.1.0

=head1 AUTHOR

Caleb Cushing <xenoterracide@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2011 by Caleb Cushing.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=cut

