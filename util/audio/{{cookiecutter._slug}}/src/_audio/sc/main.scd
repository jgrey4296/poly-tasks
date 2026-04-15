//  blah.scd -*- mode: sclang -*-
//  Summary:
//
//  Tags:
//
~mainfn = {
	"---- Running Main ----".postln;
	~pathCheck.();
	~varCheck.();
	~scriptLoad.();
	~classTest.();
	~pwdCheck.();
	~envCheck.();
	"---- Quitting ----".postln;
	0.exit;
};

~pathCheck = {
	"--- Path Check ---".postln;
	LanguageConfig.includePaths.postln;

	"--- Path Check ---".postln;
};

~varCheck = {
	var blah = "bloo";
	"--- Var Check ---".postln;
	blah.postln;
	"--- Var Check ---".postln;
};

~scriptLoad = {
	"--- Load Script ---".postln;
	"src/basic.sc".loadRelative;
	"--- Load Script ---".postln;
};

~classTest = {
	var aClass;
	"--- Class test ---".postln;
	aClass = Basic.new;
	aClass.run;
	"--- Class test ---".postln;
};

~pwdCheck = {
	"--pwd--".postln;
	"pwd".unixCmdGetStdOut.postln;
	"--pwd--".postln;
};

~envCheck = {
	"--env--".postln;
	"POLYGLOT_ROOT".getenv.postln;
	"--env--".postln;
};


(
StartUp.add({ ~mainfn.value });
// "---Recompiling---".postln;
// LanguageConfig.addIncludePath("./classes".resolveRelative);
// LanguageConfig.store;
// thisProcess.recompile;
// "---Finished Recompiling---".postln;
// StartUp.add({ thisProcess.recompile });
StartUp.run;
);
Platform.userConfigDir