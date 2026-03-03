function prng_create(_count,_power)
{
	//Set Up
    var rng = {};

    rng.count = _count;
	rng.power = _power;
	
	rng.prng_range = 0
	rng.prng = 0
	
	//Create range
	for (var i = 0; i < _count; ++i)
	{
		rng.prng_range[i] = round(100/_count)
		if (i == 0)
		{rng.prng[i] = rng.prng_range[i]}
		else
		{rng.prng[i] = rng.prng[i-1]+rng.prng_range[i]}
	}
	
    return rng;
}

function prng_roll(_rng)
{
	//Rng
	randomise()
	var rng = irandom_range(1,round(100/_rng.count)*_rng.count)
	
	for (var i = 0; i < _rng.count; ++i)
	{
		//Chose one
		if (rng <= _rng.prng[i])
		{
			if (_rng.prng_range[i] >= ((_rng.count-1)*_rng.power))
			{
				//increase and decrease the range only the Chosen range still have range
				for (var l = 0; l < _rng.count; ++l) {
					if (l == i)
					{_rng.prng_range[l] -= ((_rng.count-1)*_rng.power)}
					else
					{_rng.prng_range[l] += _rng.power}
				}
			}
			else
			{
				//Otherwise Chosen range became 0 and the other ranges are equally scaled
				for (var l = 0; l < _rng.count; ++l) {
					if (l == i)
					{_rng.prng_range[l] = 0}
					else
					{_rng.prng_range[l] = round(100/(_rng.count-1))}
				}
			}
			
			//Track the ranges
			for (var l = 0; l < _rng.count; ++l) {
				if (l == 0)
				{_rng.prng[l] = _rng.prng_range[l]}
				else
				{_rng.prng[l] = _rng.prng[l-1]+_rng.prng_range[l]}
			}
			//Worked
			return i;
		}
	}
	//Don't work
	return false;
}
