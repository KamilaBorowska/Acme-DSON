use v6;
use JSON::Tiny::Grammar;
grammar Acme::DSON::Grammar is JSON::Tiny::Grammar;

rule object    { 'such' ~ 'wow' <pairlist> }
rule pairlist  { <pair> * % [next | <[,.!?]>] }
rule pair      { <string> is <value> }
rule array     { 'so' ~ 'many' <arraylist> }
rule arraylist { <value> * % [next | and | also ] }

token value:sym<number> {
    :i
    '-'?
    [ 0 | <[1..9]> <[0..9]>* ]
    [ \. <[0..9]>+ ]?
    [ very [\+|\-]? <[0..9]>+ ]?
}

token value:sym<true>  { yes }
token value:sym<false> { no }
token value:sym<null>  { empty }

token str_escape {
    <["\\/bfnrt]> | u <odigit>
}

token odigit {
    <[0..7]>**8
}
