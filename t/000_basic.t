#!/usr/bin/perl
use strict;
use warnings;
use Test::More;

BEGIN {
    use_ok "ZMQ::Constants", ":all";
}

can_ok __PACKAGE__, @ZMQ::Constants::EXPORT_OK;
is ZMQ::Constants::get_sockopt_type(ZMQ_IDENTITY), "string", "ZMQ_IDENTITY is a string option";

done_testing;
