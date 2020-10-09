# Processing GUI System 2

# THIS IS A WORK IN PROGRESS.

<br />

This is a system you can use in Processing that allows you to easily create GUIs. This was designed in Processing 3.5.3, so you should be using at least that. It might work with earlier versions, but it hasn't been tested.

The main file (GUISystem2/GUISystem2.pde) shows some basic uses for the different element types. You can use it to start building your own GUI. To use this in your own project, you will need to copy over GUI_Element.pde and GUI_Functions.pde.

There are different basic types of GUI elements which can be used as presets, but everything about the GUI element can be configured.

<br />

### YOU NEED TO HAVE THE FOLLOWING CODE AT THE START OF YOUR PROGRAM FOR THIS TO WORK:

```
GUI_Functions GUIFunctions = new GUI_Functions();

void keyPressed() {
  GUIFunctions.keyPressed()
  if (key == 27) key = 0;
}
```

<br />
<br />
<br />
<br />
<br />

### Basic Element Types:

- Holder
- Frame
- TextFrame
- TextBox
- ImageFrame
- Button
- TextButton
- ImageButton

<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

## GUI_Element Vars:

<br />

- String Name (default: "[Error: The name for this GUI_Element is not set.]")

<br />

- boolean HasFrame (default: true)
- boolean HasText (default: false)
- boolean HasImage (default: false)
- boolean CanBePressed (default: false, if this is set to false outside init, set Pressed to false too)

<br />

- float XPos (default: 0.25)
- float YPos (default: 0.25)
- float XSize (default: 0.5)
- float YSize (default: 0.5)

<br />

- color BackgroundColor (default: color (127))
- color EdgeColor (default: color (0))
- int EdgeSize (default: 1)

<br />

- boolean Draggable (default: false)
- boolean Visible (default: true)
- boolean Enabled (default: true)
- boolean RenderChildrenNotInFrame (default: true)
- boolean UpdateChildrenNotInFrame (default: true)

<br />

- String Text (default: "Error: text not set")
- String PlaceholderText (default: "Click to edit text")
- boolean UsePlaceholderText (default: true)
- color TextColor (default: color (0))
- float TextSize (default: 1)
- String TextSizeIsRelativeTo (default: "FRAME", has to be either "FRAME" or "SCREEN")
- int TextAlignX (default: 0, 1 = RIGHT, 0 = CENTER, -1 = LEFT)
- int TextAlignY (default: 0, 1 = BOTTOM, 0 = CENTER, -1 = TOP)

<br />

- boolean TextIsEditable (default: false, if this is set to false outside init, set TextIsBeingEdited to false too)
- boolean TextResetsOnEdit (default: true)
- boolean TextIsBeingEdited (read only)
- boolean PrevTextIsBeingEdited (read only)

<br />

- PImage Image
- float ImageXSize (default: 1)
- float ImageYSize (default: 1)

<br />

- PressedBackgroundColor (default: color (63))
- boolean UsePressedColor (default: false)
- float PressedXMove (default: 0)
- float PressedYMove (default: 1)
- boolean Pressed (read only)
- boolean PrevPressed (read only)

<br />

- ArrayList <GUI_Element> Children (default: new ArrayList <GUI_Element> ())
- GUI_Element Parent (default: null)
- int FamilyLevel (default: 0)

<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

## GUI_Element Functions:

<br />

- void Render()

<br />

- boolean JustClicked()
- boolean JustReleased()
- boolean HasMouseHovering()
- boolean UserStartedEditingText()
- boolean UserStoppedEditingText()
- boolean IsInFrame()

<br />

- void AddChild (GUI_Element NewChild)
- void AddChild (int ChildIndex, GUI_Element NewChild)
- void ReplaceChild (String ChildName, GUI_Element NewChild)
- GUI_Element Child (String ChildName)
- GUI_Element Descendant (String DescendantName)
- ArrayList <GUI_Element> AllDescendants()
- GUI_Element Ancestor (String AncestorName)
- GUI_Element TopAncestor()
- ArrayList <GUI_Element> AllAncestors()

<br />

- String toString()

<br />
<br />
<br />

### Internal functions:

<br />

- void RenderBody()
- void RenderChildren()

<br />

- void Update()
- void UpdateDragging()
- void UpdatePressed()
- void UpdateTextEditing()

<br />

- void AddAllDescendants (ArrayList <GUI_Element> DescendantListIn) (this adds all the itself and all of its descendants to DescendantListIn (and yes, it is a void))

<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

## GUI_Element Constructors:

<br />

- GUI_Element (String Name)
- GUI_Element (String BasicElementType, String Name)
- GUI_Element (String Name, String[] Properties)
- GUI_Element (String[] Properties)
- GUI_Element (String Name, File ElementFolder)
- GUI_Element (File ElementFolder)

<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

## Basic Element Type Details

<br />
<br />

### Holder:

- HasFrame: false
- HasText: false
- HasImage: false

<br />
<br />

### Frame:

- HasFrame: true

<br />
<br />

### TextFrame:

- HasFrame: true
- HasText: true

<br />
<br />

### TextBox:

- HasFrame: true
- HasText: true
- TextIsEditable: true

<br />
<br />

### ImageFrame:

- HasFrame: true
- HasImage: true

<br />
<br />

### Button:

- HasFrame: true
- CanBePressed: true

<br />
<br />

### TextButton:

- HasFrame: true
- HasText: true
- CanBePressed: true

<br />
<br />

### ImageButton:

- HasFrame: true
- HasImage: true
- CanBePressed: true

<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

## Using (String[] Properties) constructors:

<br />

This constructor is used for initializing a GUI_Element from a list of properties.

You can use this to set any variable you want, as long as it's listed in this readme and it isn't read only. To do so, you need one of the Strings to be the name of the variable plus a colon at the end and the next String to be the specified value. For example, if you enter this: new String[] {"Name:", "ExampleName"} then it would set its Name to "ExampleName".

<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

## Using (File ElementFolder) constructors:

This constructor is used for loading a GUI from files.

The File given has to be a folder, and it has to have a file named Properties.txt. The Properties file holds information the same way that it would be given to a (String[] Settings) constructor.

FrameFolder can also have other folders in it, and they would be the frame's children. In order for it to recognized as a child, it has to start with "Child." followed by the type of class it is. You can place another period if you want to add addition text.

<br />

Here's an example of how you would set up a GUI that loads GUI/StartingFrame:

- GUI
  - StartingFrame
    - Properties.txt
    - Child.ThisIsANestedFrame
      - Properties.txt
      - Child.ThisIsAnotherNestedFrame
        - Properties.txt

<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

Last updated 10/09/20