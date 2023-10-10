using System.Collections.Generic
using System.Diagnostics
using Petstore.Client.Api
using Petstore.Client.Client
using Petstore.Client.Model

#region DEFINES
STATIC DEFINE HELPABOUT_ABOUTTEXT := 100
STATIC DEFINE HELPABOUT_PUSHBUTTON2 := 101
STATIC DEFINE HELPABOUT_PUSHBUTTON1 := 102
STATIC DEFINE HELPABOUT_FIXEDBITMAP1 := 103
#endregion

PARTIAL CLASS HelpAbout INHERIT DIALOGWINDOW
	PROTECT oDCAboutText AS FIXEDTEXT
	PROTECT oCCPushButton2 AS PUSHBUTTON
	PROTECT oCCPushButton1 AS PUSHBUTTON
	PROTECT oDCFixedBitmap1 AS FIXEDBITMAP
	Protect _apiClient as PetApi

	// {{%UC%}} User code starts here (DO NOT remove this line)  

CONSTRUCTOR(oParent,uExtra)

	SELF:PreInit(oParent,uExtra)

	SUPER(oParent , ResourceID{"HelpAbout" , _GetInst()} , TRUE)

	SELF:oDCAboutText := FIXEDTEXT{SELF , ResourceID{ HELPABOUT_ABOUTTEXT  , _GetInst() } }
	SELF:oDCAboutText:HyperLabel := HyperLabel{#AboutText , "VO SDI Application" , NULL_STRING , NULL_STRING}

	SELF:oCCPushButton2 := PUSHBUTTON{SELF , ResourceID{ HELPABOUT_PUSHBUTTON2  , _GetInst() } }
	SELF:oCCPushButton2:HyperLabel := HyperLabel{#PushButton2 , "Test" , NULL_STRING , NULL_STRING}

	SELF:oCCPushButton1 := PUSHBUTTON{SELF , ResourceID{ HELPABOUT_PUSHBUTTON1  , _GetInst() } }
	SELF:oCCPushButton1:HyperLabel := HyperLabel{#PushButton1 , "OK" , NULL_STRING , NULL_STRING}

	SELF:oDCFixedBitmap1 := FIXEDBITMAP{SELF , ResourceID{ HELPABOUT_FIXEDBITMAP1  , _GetInst() } }
	SELF:oDCFixedBitmap1:HyperLabel := HyperLabel{#FixedBitmap1 , "POWXSHARPBMP" , NULL_STRING , NULL_STRING}

	SELF:Caption := "About Standard Application"
	SELF:HyperLabel := HyperLabel{#HelpAbout , "About Standard Application" , NULL_STRING , NULL_STRING}

	SELF:PostInit(oParent,uExtra)

	Configuration:Default:BasePath := "https://virtserver.swaggerhub.com/OCAPTAINMYCAPTAIN/Petstore/1.0.0"
	_apiClient := PetApi{Configuration.Default}

RETURN


METHOD PostInit(oParent,uExtra)
	LOCAL sVer AS STRING
	LOCAL oSysLink AS SysLink
	LOCAL oFT1 AS FixedText
	LOCAL oHL1 AS HyperLink
	LOCAL oFont1 AS Font
	LOCAL s AS STRING

	sVer := Version()
	sVer := SubStr(sVer, RAt2(" ", sVer)+1)
	oDCAboutText:CurrentText := _CHR(13)+" VOSDIAppXSharpSummit"+_CHR(13)+_CHR(13);
		+" X# Version "+sVer+_CHR(13)+_CHR(13);
		+" Copyright (c) XSharp BV 2015-2022"

	IF IsThemeEnabled()
		s := "Visit <A HREF="+_CHR(34)+;
			"http://www.xsharp.eu"+_CHR(34)+">X#</A> on the web!"
		oSysLink := SysLink{SELF, -1, Point{10,5}, Dimension{300,20}, s}
		oSysLink:Show()
	ELSE

		s := "Visit X# on the web:"
		oFT1 := FixedText{SELF, -1, Point{10,25}, dimension{200,20}, s}
		oFT1:show()

		oFont1 := Font{,8,"Microsoft Sans Serif"}
		oFont1:Underline := TRUE

		oHL1 := HyperLink{SELF,-1,point{190,25},dimension{0,0},"http://www.xsharp.eu"}
		oHL1:font(oFont1)
		oHL1:size := dimension{150,20}
		oHL1:textcolor := color{COLORBLUE}
		oHL1:font():underline := TRUE
		oHL1:show()

	ENDIF


	RETURN NIL


METHOD PushButton1()

	SELF:EndDialog()

RETURN SELF

METHOD PushButton2()
	Local pets as List<Pet>
    Local status as List<string>

	status := List<string>{}
	status:Add("available")

	TRY
		pets := _apiClient:FindPetsByStatus(status)
    CATCH oException AS Exception
        ErrorDialog(oException)
        return
    END TRY

	foreach var pet in pets
		System.Diagnostics.Debug.WriteLine("Received Pet -> Id: " + pet:Id:ToString() + " Name: " + pet:Name + CRLF)
	next

RETURN SELF

END CLASS
