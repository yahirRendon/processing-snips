<h1 align="center">Interpolation Functions</h1>

<p>
I watched a presentation from Indiecade Europe 2019 in <a href="https://www.youtube.com/watch?v=R6UB7mVO3fY">Freya Holmer</a> discussed the simple yet power math we don't talk enough about within in game development. The first example provided was that of linear interpolation, also known as lerp. However, what I was most intrigued by was the introduction of inverse interpolation. I’ve used lerp in Processing previously but I realized it doesn’t have a built-in function for inverse lerp. I decided to create my own while also explore more nonlinear interpolations functions.
</p>

<h3>Goal</h3>
<p>
Create additional nonlinear interpolations functions along with their corresponding inverse functions.
</p>

<h3>Challenges</h3>
<p>
The inverse function was easy to create once the lerp function is understood. The lerp function in most settings looks like this:
</p>
<p>
lerp(a, b, t)
</p>
 
<p>
The a and b parameters are the beginning and ending of a desired number range while t is a value between 0.0 and 1.0. The function returns a value between a and b that linearly corresponds with a given t. In linear interpolation the desired value is found by the following formula: 
</p>
<p>
v = a + (b - a) * t
</p>
 
<p>
Below is a table that shows the resulting values between the number range of 0 and 100 as t increments by 0.1 along with the rate of change in the v result from the current return value and the prior return value.  
</p>

**t amt**|**v given t (lerp)**|**difference**
:-----:|:-----:|:-----:
0.0| 0.0| 0
0.1| 10.0| 10
0.2| 20.0| 10
0.3| 30.0| 10
0.4| 40.0| 10
0.5| 50.0| 10
0.6| 60.0| 10
0.7| 70.0| 10
0.8| 80.0| 10
0.9| 90.0| 10
1.0| 100.0| 10

<p>
To create an inverse interpolation function, one simply has to take the lerp formula and solving for t instead of v. This inverse formula for linear interpolation is as follows:
</p>
<p>
t = (v - a) / (b - a)
</p>

<p>
The inverse function returns t, a value between 0.0 and 1.0 given a value between the specified range of a and b. Below is the same table from before with a couple of added columns in which the output of the lerp function, v, is passed into the inverse lerp function to get t. As you will see passing in t to get v in the lerp function returns the inverse values when passing v to get t using the inverse lerp function. 
</p>

**t amt**|**v given t (lerp)**|**difference**|**v value**|**t given v (inv. lerp)**
:-----:|:-----:|:-----:|:-----:|:-----:
0.0| 0.0| 10| 0| 0.0
0.1| 10.0| 10| 10.0| 0.1
0.2| 20.0| 10| 20.0| 0.2
0.3| 30.0| 10| 30.0| 0.3
0.4| 40.0| 10| 40.0| 0.4
0.5| 50.0| 10| 50.0| 0.5
0.6| 60.0| 10| 60.0| 0.6
0.7| 70.0| 10| 70.0| 0.7
0.8| 80.0| 10| 80.0| 0.8
0.9| 90.0| 10| 90.0| 0.9
1.0| 100.0| 10| 100.0| 1.0

<p>
With this in mind, I recalled using the easing functions developed by Andrey Sitnik and Ivan Solovev from <a href="https://easings.net/">easings.net</a> in other projects. The easing functions are a great resource with various easing curves that can be very useful in various situations. Given their easing formulas I was able to convert several easing functions into interpolation functions and be solving for t, I was able to develop my own corresponding inverse functions. This was a fun math challenge that I hope can be useful to myself and others should such functions ever be needed. 
</p>

<p>
For an example of a nonlinear interpolation, we can take a look at the serpIn and serpInInverse functions I created. These use sine in interpolation to map the desired range between a and b. The serpIn formula is as follows:
</p>
<p>
t = 1 - cos((t * PI) / 2)
<br>
a + (b - a) * t
</p>

<p>
To obtain the inverse function it is necessary to solve for t same as we did for linear interpolation function to get the following:
</p>
<p>
t = (v - a) / (b - a)
<br>
(2 * arccos(1-t)) / PI
</p>

<p>
Below you will see a similar table used for logging the results of the lerp and inverse lerp function but now using serpIn and serpInInverse for the same range between 0 and 100. The first thing to take note of is the difference column as you will notice the change is now nonlinear. Second, that passing in t to get the corresponding v value in the serpIn function is in fact the inverse of passing in v to get the corresponding t value using the serpInInverse function.  
</p>

**t amt**|**v given t (serpIn)**|**difference**|**v value**|**t given v (inv. serpIn)**
:-----:|:-----:|:-----:|:-----:|:-----:
0.0| 0.0| **0.0** | 0.0| 0.0
0.1| 1.2| **1.2** | 1.2| 0.1
0.2| 4.9| **3.7** | 4.9| 0.2
0.3| 10.9| **6.0** | 10.9| 0.3
0.4| 19.1| **8.2** | 19.1| 0.4
0.5| 29.3| **10.2** | 29.3| 0.5
0.6| 41.2| **11.9** | 41.2| 0.6
0.7| 54.6| **13.4** | 54.6| 0.7
0.8| 69.1| **14.5** | 69.1| 0.8
0.9| 84.4| **15.3** | 84.4| 0.9
1.0| 100.0| **15.6** | 100.0| 1.0

<p>
The center square is graphing the result of the lerp function with the x-axis representing t values between 0.0 and 1.0, and the y-axis representing the v value for the desired range of 0 – 255 (common value used for rgb colors). The right most square graphs the result of the inverse function with the x- and y-axis being the t and v values respectively. Additionally, for most curves you will have the option for an in, out, and an in/out curve. This will be labeled to the left of the left most square. 
</p>

<p>
Finally, you will notice that the interpolation function will have a curve for any nonlinear interpolation while the same inverse function will be linear. This indicates the functions are working correctly as supported by the table above in that the v values have nonlinear growth while the t values are always linear (incrementing by 0.1). 
</p>

<p>
Enjoy!
</p>

<p align="center">
<img alt="sine interpolation" width="600" align="center" src="https://github.com/yahirRendon/processing-snips/blob/main/custom-functions/interpolation/interpolation-code/data/sine_interp_anim.gif"/>
</p>

<p align="center">
<img alt="quad interpolation" width="600" align="center" src="https://github.com/yahirRendon/processing-snips/blob/main/custom-functions/interpolation/interpolation-code/data/quad_interp_anim.gif"/>
</p>

<p align="center">
<img alt="exponential interpolation" width="600" align="center" src="https://github.com/yahirRendon/processing-snips/blob/main/custom-functions/interpolation/interpolation-code/data/expo_interp_anim.gif"/>
</p>




<!-- <p align="center">
  <img alt="Trominotris" width="300" align="center" src="https://github.com/yahirRendon/veiled-project/blob/main/projects/binary_message_public/output/binary_msg_visual.png" alt="visual"/>
  <img alt="Sweep Game" width="300" align="center" src="https://github.com/yahirRendon/veiled-project/blob/main/projects/binary_message_public/output/binary_msg_binary.png" alt="binary"/>
  <img alt="Game of Life"width="300" align="center" src="https://github.com/yahirRendon/veiled-project/blob/main/projects/binary_message_public/output/binary_msg_text.png" alt="text"/>
</p> -->



