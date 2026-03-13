function Equal_prng_create(_count,_power)
{
	//Set Up
    var rng = {};
    rng.count = _count;
    rng.power = _power;
    rng.Roll = 0;
    rng.take_value = 0;

    rng.prng_range = array_create(_count);
    rng.prng = array_create(_count);
	
	//Create range
    for (var i = 0; i < _count; ++i)
    {
        rng.prng[i] = round((100/_count)*(i+1));

        if (i == 0)
        {
            rng.prng_range[i] = rng.prng[i];
        }
        else
        {
            rng.prng_range[i] = rng.prng[i] - rng.prng[i-1];
        }
    }

    return rng;
}

function Equal_prng_roll(_rng)
{
	//Rng
	randomise()
	_rng.Roll = 100//irandom_range(1,100)
	
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
					{//Increase
					_rng.prng_range[l] -= ((_rng.count-1)*_rng.power)
					}
					else
					{//Decrease
					_rng.prng_range[l] += _rng.power
					}
				}
			}
			else
			{
				//Otherwise Chosen range became 0 and the other ranges are equally scaled
				for (var l = 0; l < _rng.count; ++l) {
					//Chosen range became 0
					if (l == i)
					{
						_rng.take_value = _rng.prng_range[l]
						if (_rng.take_value > 0)
						{
						_rng.prng_range[l] = 0
						}
					}
					
					//other ranges are equally scaled
					while (_rng.take_value > 0)
					{
					var idx = irandom_range(0,_rng.count-1)         //Option 1             |    //Option 2
					_rng.prng_range[idx] += _rng.power              //+= _rng.take_value   |    //+= _rng.power
					_rng.take_value -= _rng.power                   //= 0                  |    //-= _rng.power
					}
				}
			}
			
			//Track the ranges
			for (var c = 0; c < _rng.count; ++c)
			{
				if (c == 0)
				{_rng.prng[c] = round(_rng.prng_range[c])}
				else
				{_rng.prng[c] = _rng.prng[c-1]+_rng.prng_range[c]}
			}
			//Worked
			return i;
		}
	}
	//Don't work
	return false;
}


function OG_prng_create(_base,_power)
{
	var rng = {};
	rng.base = _base;
    rng.power = _power;
	rng.Roll = 0;
	rng.take_value = 0;
	return rng;
}

function OG_prng_roll(_rng)
{
	randomise()
	_rng.Roll = 100//irandom_range(1,100)
	if (_rng.base >= _rng.Roll - (_rng.take_value*_rng.power))
	{
		_rng.take_value = 0;
		return true;
	}
	else
	{
		_rng.take_value++;
		return false;
	}
}