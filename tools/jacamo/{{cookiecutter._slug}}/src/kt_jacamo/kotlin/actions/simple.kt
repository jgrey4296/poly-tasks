//  jg_action.kt -*- mode: kotlin-ts -*-
@file:JvmName("simple")

package jg.actions

import jason.asSemantics.DefaultInternalAction
import jason.asSemantics.TransitionSystem
import jason.asSemantics.Unifier
import jason.asSyntax.Term

public class SimpleAction : DefaultInternalAction() {
    val subspendIntention   = false
    val canBeUsedInContext  = false

    init {
        println("Making SimpleAction")
    }

    /** Prepare body's terms to be used in 'execute', normally it consist of cloning and applying each term */
    // override public prepareArguments(Literal body, Unifier un) : Array<Term> {}

    @Throws(Exception::class)
    public override fun execute(ts:TransitionSystem, un:Unifier, args:Array<Term>): Boolean {
        ts.logger.info("My Example Action")
        Thread.sleep(2000)
        return true
    }
}
