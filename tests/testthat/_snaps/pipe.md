# eager pipe evaluates sequentially

    Code
      NULL %>% f() %>% g() %>% h()
    Message
      baz
      bar
      foo
    Code
      NULL %!>% f() %!>% g() %!>% h()
    Message
      foo
      bar
      baz

