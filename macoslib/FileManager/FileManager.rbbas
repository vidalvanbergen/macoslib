#tag Module
Module FileManager
	#tag Method, Flags = &h1
		Protected Function GetFolderItemFromFSRef(theFSRef as FSRef) As FolderItem
		  #if targetMacOS
		    soft declare function FSGetCatalogInfo lib CarbonFramework (ByRef ref as FSRef, whichInfo as Uint32, ByRef catalogInfo as FSCatalogInfo, outName as Ptr, fsSpec as Ptr, ByRef parentRef as FSRef) as Int16
		    
		    dim parentRef as FSRef
		    dim catalogInfo as FSCatalogInfo
		    dim OSError as Int16 = FSGetCatalogInfo(theFSRef, kFSCatInfoVolume + kFSCatInfoParentDirID, catalogInfo, nil, nil, parentRef)
		    if OSError <> 0 then
		      return nil
		    end if
		    
		    dim parentDirectoryID as UInt32 = catalogInfo.parentDirID
		    If parentDirectoryID = fsRtParID then //is root directory, and parentRef is invalid
		      dim theVolume as FolderItem
		      for i as Integer = VolumeCount - 1 downto 0
		        dim v as FolderItem = Volume(i)
		        if v is nil then
		          continue
		        end if
		        if v.MacVRefNum = catalogInfo.volume then
		          theVolume = v
		          exit
		        end if
		      next
		      return theVolume
		    else
		      dim f as FolderItem = GetFolderItemFromFSRef(parentRef)
		      if f Is nil then
		        return nil
		      end if
		      
		      soft declare function FSGetCatalogInfo lib CarbonFramework (ByRef ref as FSRef, whichInfo as Uint32, catalogInfo as Ptr, ByRef outName as HFSUniStr255, fsSpec as Ptr, parentRef as Ptr) as Int16
		      
		      dim itemName as HFSUniStr255
		      OSError = FSGetCatalogInfo(theFSRef, kFSCatInfoNone, Nil, itemName, Nil, Nil)
		      if OSError <> 0 then
		        return nil
		      end if
		      return f.TrueChild(StringValue(itemName))
		    end if
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetFSRefFromFolderItem(f as FolderItem) As FSRef
		  if f is nil then
		    f = GetFolderItem("")
		    if f is nil then
		      dim nullFSRef as FSRef
		      return nullFSRef
		    end if
		  end if
		  
		  
		  #if targetMacOS
		    dim theFSRef as FSRef
		    
		    if f.Parent is nil then //f should be the root directory of the volume
		      soft declare function FSGetVolumeInfo Lib CarbonFramework (volume as Int16, volumeIndex as Integer, actualVolume as Ptr, whichInfo as UInt32, info as Ptr, volumeName as Ptr, ByRef rootDirectory as FSRef) as Int16
		      
		      dim OSErr as Int16 = FSGetVolumeInfo(f.MacVRefNum, 0, Nil, kFSVolInfoNone, Nil, Nil, theFSRef)
		      #if debugBuild
		        if OSErr <> 0 then
		          break
		        end if
		      #endif
		    else
		      dim parentFSRef as FSRef = GetFSRefFromFolderItem(f.Parent)
		      dim itemName as String = ConvertEncoding(f.Name, Encodings.UTF16)
		      
		      soft declare function FSMakeFSRefUnicode Lib CarbonFramework (ByRef parentRef as FSRef, nameLength as Integer, name as CString, enc as UInt32, ByRef outRef as FSRef) as Int16
		      
		      dim OSErr as Int16 = FSMakeFSRefUnicode(parentFSRef, Len(itemName), itemName, kTextEncodingUnknown, theFSRef)
		      #if debugBuild
		        if OSErr <> 0 then
		          break
		        end if
		      #endif
		    end if
		    return theFSRef
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsValid(theFSRef as FSRef) As Boolean
		  #if targetMacOS
		    soft declare function FSGetCatalogInfo Lib CarbonFramework (ByRef ref as FSRef, whichInfo as Integer, catalogInfo as Ptr, outName as Ptr, fsSpec as Ptr, parentRef as Ptr) as Int16
		    
		    dim OSError as Int16 = FSGetCatalogInfo(theFSRef, kFSCatInfoNone, Nil, Nil, Nil, Nil)
		    return (OSError = 0)
		  #endif
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function StringValue(s as HFSUniStr255) As String
		  dim data as String = s.StringValue(not targetBigEndian)
		  return ConvertEncoding(DefineEncoding(MidB(data, 3, 2*s.length), Encodings.UTF16), Encodings.UTF8)
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Equals(fsRef1 as FSRef, fsRef2 as FSRef) As Boolean
		  #if targetMacOS
		    soft declare function FSCompareFSRefs Lib CarbonFramework (ByRef ref1 as FSRef, ByRef ref2 as FSRef) as Int16
		    
		    dim OSError as Int16 = FSCompareFSRefs(fsRef1, fsRef2)
		    return (OSError <> 0)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetFSRefFromFSSpec(theFSSpec as FSSpec) As FSRef
		  #if targetMacOS
		    soft declare function FSpMakeFSRef Lib CarbonFramework (ByRef source as FSSpec, ByRef newRef as FSRef) as Int16
		    
		    dim theFSRef as FSRef
		    dim OSError as Int16 = FSpMakeFSRef(theFSSpec, theFSRef)
		    //you can check the return value using IsValid.
		    return theFSRef
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetFolderItemFromFSSpec(theFSSpec as FSSpec) As FolderItem
		  #if targetMacOS
		    if theFSSpec.parID = fsRtParID then //I am the root directory
		      dim f as FolderItem
		      for i as Integer = 0 to VolumeCount - 1
		        if Volume(i).MacVRefNum = theFSSpec.vRefNum then
		          f = Volume(i)
		          exit
		        end if
		      next
		      return f
		    else
		      soft declare function FSMakeFSSpec Lib CarbonFramework (vRefNum as Int16, dirID as Integer, filename as PString, ByRef spec as FSSpec) as Int16
		      
		      dim parentSpec as FSSpec
		      dim OSError as Int16 = FSMakeFSSpec(theFSSpec.vRefNum, theFSSpec.parID, "", parentSpec)
		      if OSError <> 0 then
		        return nil
		      end if
		      dim f as FolderItem = GetFolderItemFromFSSpec(parentSpec) //recursion occurs here
		      if f <> nil then
		        return f.TrueChild(ConvertEncoding(DefineEncoding(LeftB(theFSSpec.Name.char, theFSSpec.Name.length), Encodings.SystemDefault), Encodings.UTF8))
		      else
		        return nil
		      end if
		    end if
		    
		  #endif
		End Function
	#tag EndMethod


	#tag Note, Name = FSSpec Notes
		FSSpec is actually platform-dependent.  On MacOS, the last field is a Str63 -- 64-byte pascal string.
		For Windows and Unix, the last field is a Str255 -- a 256 byte pascal string.
		I've opted to declare FSSpec for MacOS.  If you copy it for use in declaring to
		QuickTime for Windows, you'll need to change the declaration, or define a new structure
		FSSpecWin.
	#tag EndNote

	#tag Note, Name = About
		This is part of the open source "MacOSLib"
		
		Original sources are located here:  http://code.google.com/p/macoslib
		
	#tag EndNote


	#tag Constant, Name = fsRtParID, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSCatInfoNone, Type = Double, Dynamic = False, Default = \"&h00000000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSCatInfoParentDirID, Type = Double, Dynamic = False, Default = \"&h00000008", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSCatInfoVolume, Type = Double, Dynamic = False, Default = \"&h00000004", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSVolInfoNone, Type = Double, Dynamic = False, Default = \"&h0000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kTextEncodingUnknown, Type = Double, Dynamic = False, Default = \"&hffff", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSCatInfoNodeID, Type = Double, Dynamic = False, Default = \"&h00000010", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSCatInfoTextEncoding, Type = Double, Dynamic = False, Default = \"&h00000001", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSCatInfoNodeFlags, Type = Double, Dynamic = False, Default = \"&h00000002", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSCatInfoCreateDate, Type = Double, Dynamic = False, Default = \"&h00000020", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSCatInfoContentMod, Type = Double, Dynamic = False, Default = \"&h00000040", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSCatInfoAttrMod, Type = Double, Dynamic = False, Default = \"&h00000080", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSCatInfoAccessDate, Type = Double, Dynamic = False, Default = \"&h00000100", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSCatInfoBackupDate, Type = Double, Dynamic = False, Default = \"&h00000200", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSCatInfoPermissions, Type = Double, Dynamic = False, Default = \"&h00000400", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSCatInfoFinderInfo, Type = Double, Dynamic = False, Default = \"&h00000800", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSCatInfoFinderXInfo, Type = Double, Dynamic = False, Default = \"&h00001000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSCatInfoValence, Type = Double, Dynamic = False, Default = \"&h00002000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSCatInfoDataSizes, Type = Double, Dynamic = False, Default = \"&h00004000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSCatInfoRsrcSizes, Type = Double, Dynamic = False, Default = \"&h00008000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSCatInfoSharingFlags, Type = Double, Dynamic = False, Default = \"&h00010000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSCatInfoUserPrivs, Type = Double, Dynamic = False, Default = \"&h00020000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSCatInfoUserAccess, Type = Double, Dynamic = False, Default = \"&h00080000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSCatInfoSetOwnership, Type = Double, Dynamic = False, Default = \"&h00100000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSCatInfoAllDates, Type = Double, Dynamic = False, Default = \"&h000003E0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSCatInfoGettableInfo, Type = Double, Dynamic = False, Default = \"&h0003FFFF", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSCatInfoSettableInfo, Type = Double, Dynamic = False, Default = \"&h00001FE3", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSCatInfoReserved, Type = Double, Dynamic = False, Default = \"&hFFFC0000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kIsInvisible, Type = Double, Dynamic = False, Default = \"&h4000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSVolInfoCreateDate, Type = Double, Dynamic = False, Default = \"&h0001", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSVolInfoModDate, Type = Double, Dynamic = False, Default = \"&h0002", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSVolInfoBackupDate, Type = Double, Dynamic = False, Default = \"&h0004", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSVolInfoCheckedDate, Type = Double, Dynamic = False, Default = \"&h0008", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSVolInfoFileCount, Type = Double, Dynamic = False, Default = \"&h0010", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSVolInfoDirCount, Type = Double, Dynamic = False, Default = \"&h0020", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSVolInfoSizes, Type = Double, Dynamic = False, Default = \"&h0040", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSVolInfoBlocks, Type = Double, Dynamic = False, Default = \"&h0080", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSVolInfoNextAlloc, Type = Double, Dynamic = False, Default = \"&h0100", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSVolInfoRsrcClump, Type = Double, Dynamic = False, Default = \"&h0200", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSVolInfoDataClump, Type = Double, Dynamic = False, Default = \"&h0400", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSVolInfoNextID, Type = Double, Dynamic = False, Default = \"&h0800", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSVolInfoFinderInfo, Type = Double, Dynamic = False, Default = \"&h1000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSVolInfoFlags, Type = Double, Dynamic = False, Default = \"&h2000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSVolInfoFSInfo, Type = Double, Dynamic = False, Default = \"&h4000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSVolInfoDriveInfo, Type = Double, Dynamic = False, Default = \"&h8000", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSVolInfoGettableInfo, Type = Double, Dynamic = False, Default = \"&hffff", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFSVolInfoSettableInfo, Type = Double, Dynamic = False, Default = \"&h3004", Scope = Protected
	#tag EndConstant


	#tag Structure, Name = FSCatalogInfo, Flags = &h0
		nodeFlags as UInt16
		  volume as Int16
		  parentDirID as UInt32
		  nodeID as UInt32
		  sharingFlags as UInt8
		  userPrivileges as UInt8
		  reserved1 as UInt8
		  reserved2 as UInt8
		  createDate as UTCDateTime
		  contentModDate as UTCDateTime
		  attributeModDate as UTCDateTime
		  accessDate as UTCDateTime
		  backupDate as UTCDateTime
		  permissions(3) as UInt32
		  finderInfo(15) as UInt8
		  extFinderInfo(15) as UInt8
		  dataLogicalSize as UInt64
		  dataPhysicalSize as UInt64
		  rsrcLogicalSize as UInt64
		  rsrcPhysicalSize as UInt64
		  valence as UInt32
		textEncodingHint as UInt32
	#tag EndStructure

	#tag Structure, Name = HFSUniStr255, Flags = &h0
		length as UInt16
		unicode(254) as UInt16
	#tag EndStructure

	#tag Structure, Name = FSRef, Flags = &h0
		hidden(79) as UInt8
	#tag EndStructure

	#tag Structure, Name = FSSpec, Flags = &h0
		vRefNum as Int16
		  parID as Int32
		name as Str63
	#tag EndStructure

	#tag Structure, Name = Str63, Flags = &h0
		length as UInt8
		char as String*63
	#tag EndStructure

	#tag Structure, Name = HIOParam, Flags = &h0
		qLink as Ptr
		  qType as Int16
		  ioTrap as Int16
		  ioCmdAddr as Ptr
		  ioCompletion as Ptr
		  ioResult as Int16
		  ioNamePtr as Ptr
		  ioVRefNum as Int16
		  ioRefNum as Int16
		  ioVersNum as Int8
		  ioPermssn as Int8
		  ioMisc as Ptr
		  ioBuffer as Ptr
		  ioReqCount as Int32
		  ioActCount as Int32
		  ioPosMode as Int16
		ioPosOffset as Int32
	#tag EndStructure

	#tag Structure, Name = GetVolParmsInfoBuffer, Flags = &h0
		vMVersion as Int16
		  vMAttrib as Int32
		  vMlocalHand as Ptr
		  vMServerAddr as Int32
		  vMVolumeGrade as Int32
		  vMForeignPrivID as Int16
		  vMExtendedAttributes as Int32
		  vMDeviceID as Ptr
		vMMaxNameLength as UInt32
	#tag EndStructure

	#tag Structure, Name = FileInfo, Flags = &h0
		fileType as OSType
		  fileCreator as OSType
		  finderFlags as UInt16
		  location as MacPoint
		reservedField as UInt16
	#tag EndStructure

	#tag Structure, Name = FSSearchParams, Flags = &h0
		searchTime as Int32
		  searchBits as Uint32
		  searchNameLength as UInt32
		  searchName as Ptr
		  searchInfo1 as Ptr
		searchInfo2 as Ptr
	#tag EndStructure

	#tag Structure, Name = FSVolumeInfo, Flags = &h0
		createDate as UTCDateTime
		  modifyDate as UTCDateTime
		  backupDate as UTCDateTime
		  checkedDate as UTCDateTime
		  fileCount as UInt32
		  folderCount as UInt32
		  totalBytes as UInt64
		  freeBytes as UInt64
		  blockSize as UInt32
		  totalBlocks as UInt32
		  freeBlocks as UInt32
		  nextAllocation as Uint32
		  rsrcClumpSize as UInt32
		  dataClumpSize as UInt32
		  nextCatalogID as UInt32
		  finderInfo(31) as UInt8
		  flags as UInt16
		  filesystemID as UInt16
		  signature as UInt16
		  driveNumber as Uint16
		driverRefNum as Int16
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
