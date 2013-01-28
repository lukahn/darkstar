---------------------------------------------
--  Hydroball
--  Deals Water damage to targets in a fan-shaped area of effect. Additional effect: STR Down
--  Type: Breath
--  Utsusemi/Blink absorb: Ignores shadows
--  Notes: STR reduced by 15%.
---------------------------------------------

require("/scripts/globals/settings");
require("/scripts/globals/status");
require("/scripts/globals/monstertpmoves");

---------------------------------------------

function OnMobSkillCheck(target,mob,skill)
	return 0;
end;

function OnMobWeaponSkill(target, mob, skill)
	local typeEffect = EFFECT_STR_DOWN;
	local statmod = MOD_INT;
	local resist = applyPlayerResistance(mob,skill,target,mob:getMod(statmod)-target:getMod(statmod),0,3);
	if(resist > 0.2) then
		target:addStatusEffect(typeEffect,40,0,180);--power=40;tic=0;duration=180;
	end

	local dmgmod = 1;
	local accmod = 1;
	local info = MobMagicalMove(mob,target,skill,mob:getWeaponDmg() * 5,accmod,dmgmod,TP_MAB_BONUS,1);
	local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,MOBSKILL_MAGICAL,MOBPARAM_WATER,MOBPARAM_IGNORE_SHADOWS);
	target:delHP(dmg);
	return dmg;
end;