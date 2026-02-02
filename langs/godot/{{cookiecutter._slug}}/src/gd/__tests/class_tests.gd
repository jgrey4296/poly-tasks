#  class_tests.gd -*- mode: gdscript -*-
class_name class_tests
extends GutTest

class TestInner1:
    extends GutTest

    var an_obj = null

    func before_each():
        pass

    func test_something():
        assert_true(an_obj == null, "Should be null")


class TestInner2:
    extends GutTest

    var an_obj = null

    func test_something():
        assert_true(an_obj == null, "Should be null")
