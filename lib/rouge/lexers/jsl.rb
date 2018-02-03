# -*- coding: utf-8 -*- #

module Rouge
  module Lexers
    class JSL < RegexLexer
      title "JSL"
      desc "The JMP Scripting Language (JSL) (jmp.com)"

      tag 'jsl'
      filenames '*.jsl'

      state :root do

        # messages
        rule /(<<)(.*?)(\(|;)/ do |m|
          token Operator, m[1]
          token Name::Function, m[2]
          token Operator, m[3]
        end

        # covers built-in and custom functions
        rule /([a-z][a-z._\s]*)(\()/i do |m|
          token Keyword, m[1]
          token Operator, m[2]
        end

        rule %r(//.*?$), Comment::Single
        rule %r(/\*.*?\*/)m, Comment::Multiline
        rule /"\\\[.*?\]\\"/m, Str              # escaped string
        rule /"(\\!"|[^"])*"/m, Str
        rule /[*!%&\[\](){}<>\|+=:\/-]/, Operator
        rule /\b[+-]?([0-9]+(\.[0-9]+)?|\.[0-9]+|\.)(e[+-]?[0-9]+)?i?\b/i, Num
        rule /\n/, Text
        rule /./, Text
      end
    end
  end
end