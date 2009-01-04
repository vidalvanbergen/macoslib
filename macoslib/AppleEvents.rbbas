#tag Module
Protected Module AppleEvents
	#tag Note, Name = About
		This is part of the open source "MacOSLib"
		
		Original sources are located here:  http://code.google.com/p/macoslib
		
	#tag EndNote


	#tag Constant, Name = typeFSRef, Type = String, Dynamic = False, Default = \"fsrf", Scope = Public
	#tag EndConstant

	#tag Constant, Name = typeBoolean, Type = String, Dynamic = False, Default = \"bool", Scope = Public
	#tag EndConstant

	#tag Constant, Name = typeStyledUnicodeText, Type = String, Dynamic = False, Default = \"sutx", Scope = Public
	#tag EndConstant


	#tag Structure, Name = AEDesc, Flags = &h0
		descriptorType as OSType
		dataHandle as Ptr
	#tag EndStructure


End Module
#tag EndModule
