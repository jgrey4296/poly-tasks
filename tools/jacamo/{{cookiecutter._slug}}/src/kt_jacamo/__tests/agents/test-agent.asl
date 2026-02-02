//  test-agent.asl -*- mode: asl-mode -*-
// usual include for all JaCaMo agent
{ include("$jacamo/templates/common-cartago.asl") }
{ include("$jacamo/templates/common-moise.asl") }
// and Test actions
{ include("$jason/test/jason/inc/test_assert.asl") }

// from JaCaMo
//{ include("tester_agent.asl") } 

!test_start.
!auto_quit.

@[test]
+!test_start
    <- .print("Starting Test");
       !assert_false(blah);
       +blah;
       !assert_true(blah);
       +count(0);
       !doCount;
       !finish.
       
         
+!doCount: count(X) & X < 5
    <- .println("waiting: ", X);
       .wait(500);
       -count(X);
       +count(X+1);
       !doCount.

+!doCount: true <- +finished.

+!finish : finished & count(X)
         <- .println("Finished");
            !assert_true(4 >= X);
            .stopMAS.          

+!finish : true <- .wait(500); !finish.

+!auto_quit : auto_shutdown_delay(X)
            <- .wait(X);
               .println("Auto Quitting");
               .stopMAS.

