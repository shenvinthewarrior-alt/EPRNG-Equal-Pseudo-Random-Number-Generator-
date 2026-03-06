function prng_create(_count,_power)
{
	//Set Up
    var rng = {};

    rng.count = _count;
	rng.power = _power;
	rng.Roll = 0;
	rng.prng_range = 0
	rng.prng = 0
	
	//Create range
	for (var i = 0; i < _count; ++i)
	{
		rng.prng_range[i] = (100/_count)
		if (i == 0)
		{
			//Scaleing
			rng.prng[i] = round(rng.prng_range[i])
			rng.prng_range[i] = rng.prng[i]
		}
		else if (i == _count-1)
		{
			//Scaleing
			rng.prng[i] = 100
			rng.prng_range[i] = (rng.prng[i])-(rng.prng[i-1])
		}
		else
		{
			//Scaleing
			if (frac(rng.prng[i-1]+rng.prng_range[i]) = 0) //checking that decimal numbers exist or not.
			//not existed, scale with other's range
			{rng.prng[i] = rng.prng[i-1]+rng.prng_range[i]}
			else
			//existed, not only scale with other's range, 
			//but also putting the left over decimal numbers to make a round function works.
			{rng.prng[i] = round(rng.prng[i-1]+frac(rng.prng[i-1]+rng.prng_range[i])+rng.prng_range[i])}
			rng.prng_range[i] = (rng.prng[i])-(rng.prng[i-1])
		}
	}
	
    return rng;
}

function prng_roll(_rng)
{
	//Rng
	randomise()
	_rng.Roll = irandom_range(1,100)
	
	for (var i = 0; i < _rng.count; ++i)
	{
		//Chose one
		if (_rng.Roll <= _rng.prng[i])
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
					{
						//all of the range will put to the last range 
						//if the Chosen range can't Share equally
						if (l == _rng.count-1)
						{_rng.prng_range[l] = 100-(round(100/(_rng.count-1))*(_rng.count-2))}
						//Otherwise
						else
						{
							// if random hit last range, Check which one will carry on last range's legacy.
							if (i = _rng.count-1){
							if (_rng.prng_range[l] == 0)
							{_rng.prng_range[l] = _rng.prng_range[_rng.count-1]}}
							//Same Share
							else
							{_rng.prng_range[l] = round(100/(_rng.count-1))}
						}
					}
				}
			}
			
			//Track the ranges
			for (var l = 0; l < _rng.count; ++l) {
				//Same scaling
				if (l == 0)
				{_rng.prng[l] = round(_rng.prng_range[l])}
				else if (l == _rng.count-1)
				{_rng.prng[l] = 100}
				else
				{
					if (frac(_rng.prng[l-1]+_rng.prng_range[l]) = 0)
					{_rng.prng[l] = _rng.prng[l-1]+_rng.prng_range[l]}
					else
					{_rng.prng[l] = round(_rng.prng[l-1]+frac(_rng.prng[l-1]+_rng.prng_range[l])+_rng.prng_range[l])}
				}
			}
			//Worked
			return i;
		}
	}
	//Don't work
	return false;
}
