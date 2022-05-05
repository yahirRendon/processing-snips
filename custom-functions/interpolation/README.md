<h1 align="center">Interpolation Functions</h1>

<p>
I found myself watching a YouTube video in which <a href="https://www.youtube.com/watch?v=R6UB7mVO3fY">Freya Holmer</a> discussed the simple yet power math we don't talk enough about in game development. This was a presentation with a similar name done at Indiecade Europe 2019. The first example provided was that of linear interpolation, also known as lerp. Something, I was loosely aware of from working with Processing. I was intrigued by two things during the speech. First, how similar lerp was to a mapping function in which you map one range of values to another range. Second, was the introduction of an inverse interpolation function. Processing doesn't have a built-in function for inverse lerp. I decided to explore this a bit more and thought about different types of nonlinear interpolation.
</p>

<h3>Goal</h3>
<p>
To create an inverse linear interpolation function as well as other nonlinear interpolation functions.
</p>

<h3>Challenges</h3>
<p>
Creating an inverse lerp function was not too difficult once I understood how the lerp function worked. Lerp takes three parameters: a, known as the start value; b, the end value; and t, which is a value between 0.0 and 1.0. The function returns a value between a and b that corresponds with t, which can be thought of as a percentage between the range comprised of a and b. In linear interpolation this found by the following formula: v = a + (b - a) * t.
</p>
 
<p>
For example, say we provide the range 0-100 and want the corresponding value at 0.5. Our formula would look like: 0 + (100 - 0) * 0.5 = 50. Let's say we want the value at 0.75: 0 + (100 - 0) * 0.75 = 75. Or, the value at 0.25: 0 + (100 - 0) * 0.25 = 25. As we can see, we are returning values in a linear fashion as t increments. Given the lerp formula we can find the inverse function by simply solving for t. The resulting formula being t = (v - a) / (b - a). The inverse function returns t given a value between a and b. For example, we can bass 50 into an inverse lerp function to get the t value of 0.5: (50 - 0) / (100 - 0) = 0.5. So, the interpolation function returns a value between a range given t while the inverse interpolation function returns a t value between 0.0 and 1.0 given a value between a specified range.
</p>
 
<p>
With this in mind, I recalled using easing function provided by Andrey Sitnik and Ivan Solovev from <a href="https://easings.net">easings.net</a>. A great resource with various easing curves that can be useful in many ways. Provided their easing formulas I was able to convert the function into an interpolation function and be solving for t, I was able to develop my own inverse functions. A fun math challenge that I hope can be useful to others should they need them.
</p>
 
<!-- <p align="center">
  <img alt="Trominotris" width="300" align="center" src="https://github.com/yahirRendon/veiled-project/blob/main/projects/binary_message_public/output/binary_msg_visual.png" alt="visual"/>
  <img alt="Sweep Game" width="300" align="center" src="https://github.com/yahirRendon/veiled-project/blob/main/projects/binary_message_public/output/binary_msg_binary.png" alt="binary"/>
  <img alt="Game of Life"width="300" align="center" src="https://github.com/yahirRendon/veiled-project/blob/main/projects/binary_message_public/output/binary_msg_text.png" alt="text"/>
</p> -->



