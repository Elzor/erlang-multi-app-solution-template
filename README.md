erlang-multi-app-solution-template
==================================
Template for build multi applications solution with help of Rebar.

Usage
---------------------
-   Build solution:
    `make`
-   Clean solution:
    `make clean`
-   Create documentation:
    `make docs`
-   Test solution:
    `make test`
-   Test one application in solution:
    `make test a=edht`
-   Test run one test case in application:
    `make test a=edht s=simple_test`
-   Build release:
    `make rel`
-   Run release:
    `make run`
-   Init release directory:
    `make init_rel a=app_name`

CI
---------------------
![alt tag](https://api.travis-ci.org/Elzor/erlang-multi-app-solution-template.png)
