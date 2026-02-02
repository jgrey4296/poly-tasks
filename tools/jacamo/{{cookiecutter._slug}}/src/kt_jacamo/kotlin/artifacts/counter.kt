// jg.kt -*- mode: kotlin-ts -*-
@file:JvmName("counter")

package jg.artifacts

import cartago.Artifact
import cartago.ObsProperty
import cartago.OpFeedbackParam
import cartago.OPERATION

public class JGCounter : Artifact() {

    // This isn't the classe's constructor, its a standard method cartago
    // will call to set up the artifact
    public fun init(initialValue: Int) {
        println("Initialising Kotlin Counter")
        defineObsProperty("count", initialValue)
    }

    @OPERATION
    fun inc(): Unit {
        val prop : ObsProperty = getObsProperty("count")
        prop.updateValue(prop.intValue() + 1)
        signal("tick")
    }

    @OPERATION
    fun inc_get(inc: Int, newValueArg: OpFeedbackParam<Int>): Unit {
        val prop = getObsProperty("count")
        val newValue = prop.intValue() + inc
        prop.updateValue(newValue)
        newValueArg.set(newValue)
    }
}
