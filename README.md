# rack-lineprof

Rack middleware for [rblineprof](https://github.com/tmm1/rblineprof).
Makes line-by-line source code profiling easy.

## Example

Add to Gemfile:
```rb
gem 'rack-lineprof', group: :development
```

Add middleware to any Rack app (e.g. config/routes.rb):
```rb
config.middleware.use Rack::Lineprof
```

Use query parameter to profile a request:
```sh
curl 'http://localhost:3000/slow-page?lineprof=active_support/core_ext/string'
```

&hellip; or specify profile target with a middleware option:
```rb
config.middleware.use Rack::Lineprof, profile: 'active_support/core_ext/string'
```

![rack-lineprof screenshot](http://f.cl.ly/items/2q2r321e1j1X3X47303F/Screen%20Shot%202013-04-18%20at%209.58.36%20PM.png)


## License

(The MIT License)

Copyright © 2014 Evan Owen &lt;kainosnoema@gmail.com&gt;

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
