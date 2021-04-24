exec function gotorc()
{
	FactsAdd("hubvisibility_riviacapital");
	FactsAdd("hubenabled_riviacapital");
	FactsAdd("tele_player_to_rivia");
}

exec function getPos() {
	var pos : Vector;
	var rot : EulerAngles;
	
	pos = thePlayer.GetWorldPosition();
	rot = thePlayer.GetWorldRotation();
	
	theGame.GetGuiManager().ShowNotification("Player pos: [" + pos.X + ", " + pos.Y + ", " + pos.Z + "], rot: [" + rot.Pitch + ", " + rot.Yaw + ", " + rot.Roll + "]");
	LogChannel('RIVIA_HUB', pos.X + " " + pos.Y + " " + pos.Z + " " + rot.Pitch + " " + rot.Yaw + " " + rot.Roll);
}
