vCard module
============

This program can be used for strict validation and parsing of vCards.

Additional scripts:

* `split.sh` - Split a multiple vCards file into individual files
* `sort-lines.sh` - Sort vCard property lines according to a custom key
* `join-lines.sh` - Join previously split vCard lines
* `split-lines.sh` - Split long vCard lines

Test
----

Requires `shunit2`.

    git submodule update --init
    make test

Installation / upgrade
----------------------

    sudo pip install --upgrade vcard

Examples
--------

The `test` directory contains two valid vCards: `maximal.vcf` and `minimal.vcf`.
