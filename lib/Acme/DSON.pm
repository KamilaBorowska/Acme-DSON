use v6;

module Acme::DSON;

use JSON::Tiny;
use Acme::DSON::Actions;
use Acme::DSON::Grammar;

proto to-dson($) is export {*}

multi to-dson(Real:D $d is copy) {
    return $d.subst('e', 'very');
}
multi to-dson(Bool:D $d) {
    return $d ?? 'notfalse' !! 'nottrue';
}
multi to-dson(Str:D $d) { to-json $d }
multi to-dson(Positional:D $d) {
    return 'so '
            ~ $d.map(&to-dson).join(' next ')
            ~ ' many';
}
multi to-dson(Associative:D $d) {
    return 'such '
            ~ $d.map({ to-dson(.key) ~ ' is ' ~ to-dson(.value) }).join(' next ')
            ~ ' wow';
}
multi to-dson(Mu:U $) { 'nullish' }
multi to-dson(Mu:D $s) {
    die "Can't serialize an object of type " ~ $s.WHAT.perl
}

sub from-dson($text) is export {
    my $a = Acme::DSON::Actions.new();
    my $o = Acme::DSON::Grammar.parse($text, :actions($a));
    return $o.ast;
}
