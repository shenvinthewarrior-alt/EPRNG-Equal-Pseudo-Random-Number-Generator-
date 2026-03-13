//Draw
draw_text(x, y-32, "Rng: " + string(rng.base) + " >= " + string(rng.Roll) + " - " + string(rng.take_value*rng.power) );
draw_text(x, y-64, "Cal_Rng: " + string(rng.Roll - (rng.take_value*rng.power)) )
draw_text(x, y-96, "Result: " + string(good) )
