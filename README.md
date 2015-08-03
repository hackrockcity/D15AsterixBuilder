# D15 Asterix Builder

This creates the JSON file to use with Displayable (aka Moonpaper).

It's a very rough approximation of the Asterix based on playing with
rotate and eyeballing until things sort of lined up.  Hopefully it's
good enough for jazz.

If you want to use this for changing Asterix set ENABLE\_OCTACAD to
true and run.  You should see an extra Octahedron sticking through
the bottom of the floor.  Use the keyboard to move/rotate until it
is where you want and then hit 'p' to print out the call to
instantiate that Octahedron.  You can append this in the octas
array.

Keys

* Arrows - Move in the X/Z plane
* q,Q,a,A - Move in the Y plane (caps=faster)
* z,Z - Rotate in Z axis (caps=reverse)
* y,Y - Rotate in Y axis
* x,X - Rotate in X axis
* O - Change order of rotation calls
* R - Reset rotation+order
* P - Print call to instantiate

To write a new JSON file set WRITE\_JSON to true and run.  The 
JSON file will be written on the first frame.  The interactive 
octahedron will not be included.

