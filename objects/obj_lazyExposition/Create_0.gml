/// @description 

xOff = 0;
yOff = 0;

text = "R - Create Quantum Rift, Esc - Reset Level";
text2 = "WARNING: Quantum Rift unstable! Only one Rift can be sustained.";

if (room == rm_intro) {
	xOff = 550;
	yOff = -80;
	
	text = "A+D / Arrows: Move, Up/Space/W: Jump, Esc: Reset Level";
	text2 = "";
}

if (room == rm_level_06) {
	xOff = 550;
	yOff = -80;
	
	text = "WARNING: Quantum Rift deteriorating. Defensive protocol engaged.";
	text2 = "Two Rifts can now be established.";
}
