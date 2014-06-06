use v6;
use JSON::Tiny::Grammar;
grammar Acme::DSON::Grammar is JSON::Tiny::Grammar;

rule object    { 'such' ~ 'wow' <pairlist> }
rule pairlist  { <pair> * % 'next' }
rule pair      { <string> is <value> }
rule array     { 'so' ~ 'many' <arraylist> }
rule arraylist { <value> * % 'next' }

token value:sym<number> {
    :i
    '-'?
    [ 0 | <[1..9]> <[0..9]>* ]
    [ \. <[0..9]>+ ]?
    [ very [\+|\-]? <[0..9]>+ ]?
}

token value:sym<true>  { notfalse }
token value:sym<false> { nottrue }
token value:sym<null>  { nullish }
