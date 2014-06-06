use v6;
use JSON::Tiny::Actions;
class Acme::DSON::Actions is JSON::Tiny::Actions;

method value:sym<number>($/) { make +$/.Str.subst('very', 'e').subst('VERY', 'E') }
