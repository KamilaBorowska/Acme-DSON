use v6;
use JSON::Tiny::Actions;
class Acme::DSON::Actions is JSON::Tiny::Actions;

method value:sym<number>($/) { make +$/.Str.subst('very', 'e').subst('VERY', 'E') }

my %h = '\\' => "\\",
        '/' => "/",
        'b' => "\b",
        'n' => "\n",
        't' => "\t",
        'f' => "\f",
        'r' => "\r",
        '"' => "\"";
method str_escape($/) {
    if $<odigit> {
        make chr(:8(~$<odigit>));
    } else {
        make %h{~$/};
    }
}
