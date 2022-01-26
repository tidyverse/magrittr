# eager pipe evaluates sequentially

    Code
      NULL %>% f() %>% g() %>% h()
    Message <simpleMessage>
      baz
      bar
      foo
    Code
      NULL %!>% f() %!>% g() %!>% h()
    Message <simpleMessage>
      foo
      bar
      baz

