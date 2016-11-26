unit class Pod::To::Markdown::Fenced;

use Pod::To::Markdown;

multi sub pod2markdown(Pod::Block::Code $pad) is export is default {
    my $lang = $pad.config<lang> // '';
    return "```$lang\n" ~
      $pad.contents».&pod2markdown.join.trim-trailing
      ~ "\n```"
}

method render($pod) {
    pod2markdown($pod);
}

=begin pod

=head1 NAME

Pod::To::Markdown::Fenced - Render POD code blocks as fenced (```) code blocks

=head1 SYNOPSIS

Do you like syntax highlighting?

Do you hate maintaining POD and Markdown seperately if you want language specific fenced code blocks in your README so GitHub (GFM) does syntax highlighting.

If so, this module is for you.

This module overrides `Pod::To::Markdown`'s multi-sub that handles code blocks. In the resulting output, that code block will now be fenced rather than indented. In this case, it is no longer strict Markdown, but something closer to CommonMark.

If that all it did this module would be pretty useless, so in addition, you can define a `lang` config option, which will be set as the "info string" on the code block. This will allow syntax highlighting of the code block where supported (like Github).

=head1 Usage

From command line:

=begin code
    $ perl6 --doc=Markdown::Fenced lib/MyClass.pm
=end code

From Perl 6:
=begin code :lang<perl6>

    Use Pod::To::Markdown::Fenced;

    Here is some perl

    =begin code :lang<perl6>
    Foo.new( :$bar = 1, :$baz = False )
    =end code

    Some not perl

    =begin code :lang<javascript>
    console.log(['apple', 'orange'].length);
    =end code

    And a normal code block

    =begin code
    I'm just normal
    =end code

    say pod2markdown($=pod);

=end code

Which produces the following output

=begin code :lang<markdown>

    Here is some perl

    ```perl6
    Foo.new( :$bar = 1, :$baz = False )
    ```

    And some not perl

    ```javascript
    console.log(['apple', 'orange'].length);
    ```

    And a normal code block
    ```
    I'm just normal
    ```
        
=end code

For another example, refer to my `Net::Netmask` module on Github. The README.md file is generated completely by this module;

=end pod
