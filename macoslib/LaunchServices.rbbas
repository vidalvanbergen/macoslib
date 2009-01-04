#tag Module
Protected Module LaunchServices
	#tag Method, Flags = &h0
		Function FindAppForItem(item as FolderItem, roles as Uint32 = &hFFFFFFFF) As FolderItem
		  //the roles parameter should be one or more of the kKSRoles* constants, combined using Or.
		  
		  #if targetMacOS
		    soft declare function LSGetApplicationForItem lib CarbonFramework (ByRef inItemRef as FSRef, inRolesMask as UInt32, ByRef outAppRef as FSRef, outAppURL as Ptr) as Integer
		    
		    dim itemRef as FSRef = FileManager.GetFSRefFromFolderItem(item)
		    if not FileManager.IsValid(itemRef) then
		      return nil
		    end if
		    
		    dim appRef as FSRef
		    
		    dim OSError as Integer = LSGetApplicationForItem(itemRef, roles, appRef, nil)
		    if OSError = noErr then
		      return FileManager.GetFolderItemFromFSRef(appRef)
		    else
		      return nil
		    end if
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindAppForInfo(type as OSType, creator as OSType, extension as String, roles as Uint32 = kLSRolesAll) As FolderItem
		  #if targetMacOS
		    soft declare function LSGetApplicationForInfo lib CarbonFramework (inType as OSType, inCreator as OSType, inExtension as CFStringRef, inRolesMask as UInt32, ByRef outAppRef as FSRef, outAppURL as Ptr) as Integer
		    
		    dim outAppRef as FSRef
		    dim OSError as Integer
		    if extension <> "" then
		      OSError = LSGetApplicationForInfo(type, creator, StripLeadingPeriod(extension), roles, outAppRef, nil)
		    else
		      OSError = LSGetApplicationForInfo(type, creator, nil, roles, outAppRef, nil)
		    end if
		    if OSError = 0 then
		      return FileManager.GetFolderItemFromFSRef(outAppRef)
		    else
		      return nil
		    end if
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function StripLeadingPeriod(s as String) As String
		  if Left(s, 1) = "." then
		    return Mid(s, 2)
		  else
		    return s
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindAppForMIMEType(MIMEType as String, roles as UInt32 = &hffffffff) As FolderItem
		  #if targetMacOS
		    soft declare function LSCopyApplicationForMIMEType lib CarbonFramework (inMIMEType as CFStringRef, inRolesMask as Uint32, ByRef outAppURL as Ptr) as Integer
		    
		    dim ref as Ptr
		    dim OSStatus as Integer= LSCopyApplicationForMIMEType(MIMEType, roles, ref)
		    if OSStatus = 0 then
		      dim theURL as new CFURL(ref, true)
		      return theURL.Item
		    end if
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindAppsForURL(inURL as CFURL, roles as UInt32 = &hffffffff) As FolderItem()
		  //From Apple docs:
		  //If the item URL’s scheme is file (designating either a file or a directory), the selection of suitable applications
		  //is based on the designated item’s filename extension, file type, and creator signature, along with the role
		  //specified by the inRolesMask parameter; otherwise, it is based on the URL scheme (such as http, ftp, or mailto).
		  
		  
		  if inURL is nil then
		    dim noList() as FolderItem
		    return noList
		  end if
		  
		  #if targetMacOS
		    soft declare function LSCopyApplicationURLsForURL lib CarbonFramework (inURL as Ptr, inRolesMask as UInt32) as Ptr
		    
		    dim theArray as new CFArray(LSCopyApplicationURLsForURL(inURL, roles), true)
		    if theArray = nil then
		      dim noList() as FolderItem
		      return noList
		    end if
		    
		    dim theList() as FolderItem
		    for i as Integer = 0 to theArray.Count - 1
		      try
		        dim theURL as CFURL = CFURL(theArray.Value(i))
		        theList.Append theURL.Item
		        
		      catch ice as IllegalCastException
		        //this should not happen, but if it does...
		      end try
		    next
		    
		    return theList
		  #endif
		  
		  
		  
		  
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FindApp(creator as OSType, bundleID as String, name as String) As FolderItem
		  #if targetMacOS
		    soft declare function LSFindApplicationForInfo lib Carbonframework (inCreator as OSType, inBundleID as CFStringRef, inName as CFStringRef, ByRef outAppRef as FSRef, outAppURL as Ptr) as Integer
		    
		    dim outAppRef as FSRef
		    
		    if bundleID <> "" then
		      if name <> "" then
		        dim OSError as Integer = LSFindApplicationForInfo(creator, bundleID, name, outAppRef, nil)
		      else
		        dim OSError as Integer = LSFindApplicationForInfo(creator, bundleID, nil, outAppRef, nil)
		      end if
		    else
		      if name <> "" then
		        dim OSError as Integer = LSFindApplicationForInfo(creator, nil, name, outAppRef, nil)
		      else
		        dim OSError as Integer = LSFindApplicationForInfo(creator, nil, nil, outAppRef, nil)
		      end if
		    end if
		    return FileManager.GetFolderItemFromFSRef(outAppRef)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CanAppOpenItem(theApp as FolderItem, theItem as FolderItem, roles as UInt32 = &hffffffff, flags as UInt32 = 1) As Boolean
		  //The flags parameter takes one of the constants kLSAcceptDefault, kLSAcceptAllowLoginUI.
		  
		  if theApp is nil then
		    return false
		  end if
		  if theItem is nil then
		    return false
		  end if
		  
		  #if targetMacOS
		    soft declare function LSCanRefAcceptItem lib CarbonFramework (ByRef inItemFSRef as FSRef, ByRef inTargetFSRef as FSRef, inRolesMask as Uint32, inFlags as UInt32, ByRef outAcceptsItem as Boolean) as Integer
		    
		    dim inItemFSRef as FSRef = FileManager.GetFSRefFromFolderItem(theItem)
		    dim inTargetFSRef as FSRef = FileManager.GetFSRefFromFolderItem(theApp)
		    dim outAcceptsItem as Boolean
		    dim OSError as Integer = LSCanRefAcceptItem(inItemFSRef, inTargetFSRef, roles, flags, outAcceptsItem)
		    return outAcceptsItem
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CanAppOpenItem(theApp as FolderItem, theItem as CFURL, roles as UInt32 = &hffffffff, flags as UInt32 = 1) As Boolean
		  //The flags parameter takes one of the constants kLSAcceptDefault, kLSAcceptAllowLoginUI.
		  
		  if theApp is nil then
		    return false
		  end if
		  if theItem is nil then
		    return false
		  end if
		  
		  #if targetMacOS
		    soft declare function LSCanURLAcceptURL lib CarbonFramework (inItemURL as Ptr, inTargetURL as Ptr, inRolesMask as Uint32, inFlags as UInt32, ByRef outAcceptsItem as Boolean) as Integer
		    
		    dim inTargetURL as new CFURL(theApp)
		    dim outAcceptsItem as Boolean
		    dim OSError as Integer = LSCanURLAcceptURL(theItem, inTargetURL, roles, flags, outAcceptsItem)
		    return outAcceptsItem
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub OpenApp(theApp as FolderItem, launchFlags as UInt32 = 1, argv as String)
		  if theApp is nil then
		    return
		  end if
		  
		  #if targetMacOS
		    soft declare function LSOpenApplication lib CarbonFramework (inAppParams as Ptr, outPSN as Ptr) as Integer
		    
		    dim inAppParams as new MemoryBlock(LSApplicationParameters.Size)
		    inAppParams.UInt32Value(4) = launchFlags
		    dim appRef as FSRef = FileManager.GetFSRefFromFolderItem(theApp)
		    dim appRefCopy as MemoryBlock = appRef.StringValue(not targetBigEndian)
		    inAppParams.Ptr(8) = appRefCopy
		    
		    
		    dim argvWrapper as CFString = argv
		    dim argvArray as new CFArray(Array(argvWrapper))
		    inAppParams.Ptr(20) = argvArray
		    
		    
		    dim OSError as Integer = LSOpenApplication(inAppParams, nil)
		  #endif
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DefaultAppBundleIDForScheme(urlScheme as String) As String
		  #if targetMacOS
		    soft declare function LSCopyDefaultHandlerForURLScheme lib CarbonFramework (inURLScheme as CFStringRef) as CFStringRef
		    
		    return LSCopyDefaultHandlerForURLScheme(urlScheme)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DefaultAppBundleIDForScheme(urlScheme as String, assigns bundleID as String)
		  #if targetMacOS
		    soft declare function LSSetDefaultHandlerForURLScheme lib CarbonFramework (inURLScheme as CFStringRef, inHandlerBundleID as CFStringRef) as Integer
		    
		    dim OSError as Integer = LSSetDefaultHandlerForURLScheme(urlScheme, bundleID)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SendURLToApplication(url as String, appItem as FolderItem)
		  
		  if url = "" then
		    return
		  end if
		  if appItem is nil then
		    return
		  end if
		  
		  #if targetMacOS
		    soft declare function LSOpenURLsWithRole lib CarbonFramework (inURLs as Ptr, inRole as UInt32, inAEParam as Ptr, ByRef inAppParams as LSApplicationParameters, outPSNs as Ptr, inMaxPSNCount as Integer) as Integer
		    
		    
		    dim theArray as new CFArray(Array(new CFURL(url)))
		    const paramIgnoredBecauseinAppParamsNotNil = 0
		    
		    dim appParams as LSApplicationParameters
		    dim appRef as FSRef = FileManager.GetFSRefFromFolderItem(appItem)
		    dim appPtr as MemoryBlock = appRef.StringValue(targetLittleEndian)
		    appParams.application = appPtr
		    
		    dim OSError as Integer = LSOpenURLsWithRole(theArray, paramIgnoredBecauseinAppParamsNotNil, nil, appParams, nil, 0)
		  #endif
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		This is part of the open source "MacOSLib"
		
		Original sources are located here:  http://code.google.com/p/macoslib
		
	#tag EndNote


	#tag Constant, Name = kLSRolesNone, Type = Double, Dynamic = False, Default = \"&h00000001", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLSRolesViewer, Type = Double, Dynamic = False, Default = \"&h00000002", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLSRolesEditor, Type = Double, Dynamic = False, Default = \"&h00000004", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLSRolesShell, Type = Double, Dynamic = False, Default = \"&h00000008", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLSRolesAll, Type = Double, Dynamic = False, Default = \"&hffffffff", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLSLaunchDefaults, Type = Double, Dynamic = False, Default = \"&h00000001", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLSLaunchAndPrint, Type = Double, Dynamic = False, Default = \"&h00000002", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLSAcceptAllowLoginUI, Type = Double, Dynamic = False, Default = \"&h00000002", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLSLaunchReserved2, Type = Double, Dynamic = False, Default = \"&h00000004", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLSLaunchReserved3, Type = Double, Dynamic = False, Default = \"&h00000008", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLSLaunchReserved4, Type = Double, Dynamic = False, Default = \"&h00000010", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLSLaunchReserved5, Type = Double, Dynamic = False, Default = \"&h00000020", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLSLaunchAndDisplayErrors, Type = Double, Dynamic = False, Default = \"&h00000040", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLSLaunchInhibitBGOnly, Type = Double, Dynamic = False, Default = \"&h00000080", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLSLaunchDontAddToRecents, Type = Double, Dynamic = False, Default = \"&h00000100", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLSLaunchDontSwitch, Type = Double, Dynamic = False, Default = \"&h00000200", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLSLaunchNoParams, Type = Double, Dynamic = False, Default = \"&h00000800", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLSLaunchAsync, Type = Double, Dynamic = False, Default = \"&h00010000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLSLaunchStartClassic, Type = Double, Dynamic = False, Default = \"&h00020000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLSLaunchInClassic, Type = Double, Dynamic = False, Default = \"&h00040000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLSLaunchNewInstance, Type = Double, Dynamic = False, Default = \"&h00080000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLSLaunchAndHide, Type = Double, Dynamic = False, Default = \"&h00100000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLSLaunchAndHideOthers, Type = Double, Dynamic = False, Default = \"&h00200000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLSLaunchHasUntrustedContents, Type = Double, Dynamic = False, Default = \"&h00400000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLSRequestExtension, Type = Double, Dynamic = False, Default = \"&h00000001", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLSRequestTypeCreator, Type = Double, Dynamic = False, Default = \"&h00000002", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLSRequestBasicFlagsOnly, Type = Double, Dynamic = False, Default = \"&h00000004", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLSRequestAppTypeFlags, Type = Double, Dynamic = False, Default = \"&h00000008", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLSRequestAllFlags, Type = Double, Dynamic = False, Default = \"&h00000010", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLSRequestIconAndKind, Type = Double, Dynamic = False, Default = \"&h00000020", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLSRequestExtensionFlagsOnly, Type = Double, Dynamic = False, Default = \"&h00000040", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLSRequestAllInfo, Type = Double, Dynamic = False, Default = \"&hFFFFFFFF", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLSUnknownType, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLSUnknownCreator, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLSAcceptDefault, Type = Double, Dynamic = False, Default = \"&h00000001", Scope = Public
	#tag EndConstant


	#tag Structure, Name = LSApplicationParameters, Flags = &h0
		version as Int32
		  flags as UInt32
		  application as Ptr
		  asyncLaunchRefCon as Ptr
		  environment as Ptr
		  argv as Ptr
		initialEvent as Ptr
	#tag EndStructure

	#tag Structure, Name = LSLaunchFSRefSpec, Flags = &h0
		appRef as Ptr
		  numDocs as UInt32
		  itemRefs as Ptr
		  passThruParams as Ptr
		  launchFlags as Uint32
		asyncRefCon as Ptr
	#tag EndStructure

	#tag Structure, Name = LSLaunchURLSpec, Flags = &h0
		appURL as Ptr
		  itemURLs as Ptr
		  passThruParams as Ptr
		  launchFlags as UInt32
		asyncRefCon as Ptr
	#tag EndStructure

	#tag Structure, Name = LSItemInfoRecord, Flags = &h0
		flags as UInt32
		  filetype as OSType
		  creator as OSType
		  extension as Ptr
		  iconFileName as Ptr
		kindID as UInt32
	#tag EndStructure


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
