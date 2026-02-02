//  BasicTest.kt -*- mode: kotlin-ts-mode -*-
//  Summary:
//
//  Tags:
//

import kotlin.test.Test
import kotlin.test.assertEquals
import jg.*

class BasicTests {

    // @DisplayName("should test basic retrieval")
    @Test
    fun shouldGetBlah() {
        var basic: Basic = Basic()
        assertEquals("blah", basic.get_something())
    }

    @Test
    fun shouldDoMath() {
        assertEquals(2, 2)
    }

}