배경
==========

이 문서에 대한 기여자들은 수백개의 애플리케이션 개발과 배포에 직접적으로 참여했으며, [Heroku](http://www.heroku.com/) 플랫폼에서의 작업을 통해 방대한 양의 애플리케이션 개발, 운영, 확장을 간접적으로 관찰했습니다.

이 문서는 생태계의 다양한 SaaS 애플리케이션에 대한 저희의 경험과 관찰을 종합한 결과물입니다. 특히 응용프로그램의 시간이 지남에 따른 유기적인 성장, 애플리케이션의 코드베이스에서 작업하는 개발자들 간의 협업, [소프트웨어가 낡는 것에 의한 비용을 피하는 법](http://blog.heroku.com/archives/2011/6/28/the_new_heroku_4_erosion_resistance_explicit_contracts/)에 집중하여 애플리케이션 개발에 대한 이상적인 방법을 찾고자 했습니다.


이 문서는 저희가 현대적인 애플리케이션 개발에서 만났던 몇가지 시스템적인 문제에 대한 인지도를 높히고, 이 문제들에 대해 논의를 하기 위한 공통의 어휘를 제공하며, 이 문제들에 대한 넓은 개념의 해결책과 그에 대한 용어를 제공하기 위해 작성 되었습니다. 형식은 Martin Fowler의 책, *[Patterns of Enterprise Application Architecture](http://books.google.com/books/about/Patterns_of_enterprise_application_archi.html?id=FyWZt5DdvFkC)*과 *[Refactoring](http://books.google.com/books/about/Refactoring.html?id=1MsETFPD3I0C)*에서 영감을 받았습니다.