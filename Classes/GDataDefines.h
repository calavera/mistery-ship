/* Copyright (c) 2008 Google Inc.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

// 
// GDataDefines.h
//

//
// The developer may choose to define these in the project:
//   #define GDATA_FOUNDATION_ONLY 1     // builds without AppKit or Carbon  
//   #define STRIP_GDATA_FETCH_LOGGING 1 // omit http logging code
//

#ifdef GDATA_TARGET_NAMESPACE
// prefix all GData class names with GDATA_TARGET_NAMESPACE for this target
  #import "GDataTargetNamespace.h"
#endif

#if TARGET_OS_IPHONE // iPhone SDK

  #define GDATA_IPHONE 1

#endif

#if GDATA_IPHONE

  #define GDATA_FOUNDATION_ONLY 1

  #define GDATA_USES_LIBXML 1

  #import "GDataXMLNode.h"

  #define NSXMLDocument                  GDataXMLDocument
  #define NSXMLElement                   GDataXMLElement
  #define NSXMLNode                      GDataXMLNode
  #define NSXMLNodeKind                  GDataXMLNodeKind
  #define NSXMLInvalidKind               GDataXMLInvalidKind
  #define NSXMLDocumentKind              GDataXMLDocumentKind
  #define NSXMLElementKind               GDataXMLElementKind
  #define NSXMLAttributeKind             GDataXMLAttributeKind
  #define NSXMLNamespaceKind             GDataXMLNamespaceKind
  #define NSXMLProcessingInstructionKind GDataXMLDocumentKind
  #define NSXMLCommentKind               GDataXMLCommentKind
  #define NSXMLTextKind                  GDataXMLTextKind
  #define NSXMLDTDKind                   GDataXMLDTDKind
  #define NSXMLEntityDeclarationKind     GDataXMLEntityDeclarationKind
  #define NSXMLAttributeDeclarationKind  GDataXMLAttributeDeclarationKind
  #define NSXMLElementDeclarationKind    GDataXMLElementDeclarationKind
  #define NSXMLNotationDeclarationKind   GDataXMLNotationDeclarationKind

  // properties used for retaining the XML tree in the classes that use them
  #define kGDataXMLDocumentPropertyKey @"_XMLDocument"
  #define kGDataXMLElementPropertyKey  @"_XMLElement"
#endif

// To simplify support for 64bit (and Leopard in general), we provide the type
// defines for non Leopard SDKs
#if MAC_OS_X_VERSION_MAX_ALLOWED <= MAC_OS_X_VERSION_10_4
 // NSInteger/NSUInteger and Max/Mins
 #ifndef NSINTEGER_DEFINED
  #if __LP64__ || NS_BUILD_32_LIKE_64
   typedef long NSInteger;
   typedef unsigned long NSUInteger;
  #else
   typedef int NSInteger;
   typedef unsigned int NSUInteger;
  #endif
  #define NSIntegerMax    LONG_MAX
  #define NSIntegerMin    LONG_MIN
  #define NSUIntegerMax   ULONG_MAX
  #define NSINTEGER_DEFINED 1
 #endif  // NSINTEGER_DEFINED
#endif  // MAC_OS_X_VERSION_MAX_ALLOWED <= MAC_OS_X_VERSION_10_4
