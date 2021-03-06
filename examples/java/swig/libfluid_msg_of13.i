/* File: example.i */
%module(directors="1") libfluid_msg_of13
#pragma SWIG nowarn=362,503,509
%{
/* Includes the header in the wrapper code */
typedef unsigned int of_error;
#include <fluid/of13msg.hh>
%}
%include "stdint.i"
%include "cdata.i"
%include "various.i"
%include "std_vector.i"
%include "std_string.i"


%typemap(jni)    (uint8_t *) "jbyteArray"
%typemap(jni)    (void *) "jbyteArray"
%typemap(jtype)  (uint8_t *) "byte[]"
%typemap(jtype)  (void *) "byte[]"
%typemap(jstype) (uint8_t *) "byte[]"
%typemap(jstype) (void *) "byte[]"


typedef std::string<fluid_msg::of13::SwitchDesc> String;

%template(Ports_) std::vector<fluid_msg::of13::Port>;



%typemap(in) void* {
    $1 = (void *) JCALL2(GetByteArrayElements, jenv, $input, 0);
}

%typemap(in) uint8_t* {
    $1 = (uint8_t *) JCALL2(GetByteArrayElements, jenv, $input, 0);
}

%typemap(javain) (uint8_t *) "$javainput"
%typemap(javain) (void *) "$javainput"

%typemap(out, descriptor="[B") void* data() {
    $result = (jenv)->NewByteArray(arg1->data_len());
    (jenv)->SetByteArrayRegion($result, 0, arg1->data_len(), (jbyte*) $1);
}

%typemap(out, descriptor="[B") uint8_t* {
        int len =  htons(*((uint16_t*) $1 + 1));
    $result = (jenv)->NewByteArray(len);
    (jenv)->SetByteArrayRegion($result, 0, len, (jbyte*) $1);
}

%typemap(javaout) (uint8_t *) {
 return $jnicall;
}

%typemap(javaout) (void *) {
 return $jnicall;
}

%include "fluid/util/ethaddr.hh"
%include "fluid/util/ipaddr.hh"

%include "fluid/ofcommon/action.hh"
%include "fluid/ofcommon/common.hh"
%include "fluid/ofcommon/msg.hh"

%include "fluid/of13/of13match.hh"
%include "fluid/of13/of13instruction.hh"
%include "fluid/of13/of13action.hh"
%include "fluid/of13/of13common.hh"
%include "fluid/of13/of13meter.hh"

%include "fluid/of13msg.hh"

typedef unsigned int of_error;
