#!/usr/bin/perl
use strict;
use warnings;
use Test::More;

BEGIN {
    use_ok "ZMQ::Constants", ":v2.1.11", ":all";
}

foreach my $constant_set (@ZMQ::Constants::CONSTANT_SETS) {
    if ( $constant_set->match('2.1.11') ) {
        my @list = $constant_set->get_export_oks();
        can_ok __PACKAGE__, @list;
    }
}

foreach my $noexist (
    qw(
    ZMQ_MAXMSGSIZE
    ZMQ_SNDHWM
    ZMQ_RCVHWM
    ZMQ_MULTICAST_HOPS
    ZMQ_RCVTIMEO
    ZMQ_SNDTIMEO
    ZMQ_IPV4ONLY
    ZMQ_LAST_ENDPOINT
    ZMQ_FAIL_UNROUTABLE
    )
  )
{
    ok !__PACKAGE__->can($noexist), "$noexist should not exist in v2.1.11";
}

foreach my $exist (
    qw(
    ZMQ_MAX_VSM_SIZE
    ZMQ_DELIMITER
    ZMQ_VSM
    ZMQ_MSG_MORE
    ZMQ_MSG_SHARED
    ZMQ_MSG_MASK
    ZMQ_HWM
    ZMQ_SWAP
    ZMQ_RECOVERY_IVL_MSEC
    ZMQ_NOBLOCK
    )
  )
{
    my $code = __PACKAGE__->can($exist),;
    ok $code, "$exist should exist in v2.1.11";
    my $callable = eval { $code->(); 1 } ? 1 : 0;
    ok $callable, "$exist is callable";
}

done_testing;
