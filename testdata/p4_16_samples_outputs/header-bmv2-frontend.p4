#include <core.p4>
#include <v1model.p4>

header hdr {
    bit<32> f;
}

control compute(inout hdr h) {
    hdr tmp_0;
    bit<32> tmp;
    apply {
        tmp = h.f + 32w1;
        tmp_0.f = tmp;
        h.f = tmp_0.f;
    }
}

struct Headers {
    hdr h;
}

struct Meta {
}

parser p(packet_in b, out Headers h, inout Meta m, inout standard_metadata_t sm) {
    state start {
        b.extract<hdr>(h.h);
        transition accept;
    }
}

control vrfy(in Headers h, inout Meta m) {
    apply {
    }
}

control update(inout Headers h, inout Meta m) {
    apply {
    }
}

control egress(inout Headers h, inout Meta m, inout standard_metadata_t sm) {
    apply {
    }
}

control deparser(packet_out b, in Headers h) {
    apply {
        b.emit<hdr>(h.h);
    }
}

control ingress(inout Headers h, inout Meta m, inout standard_metadata_t sm) {
    @name("c") compute() c_0;
    apply {
        c_0.apply(h.h);
        sm.egress_spec = 9w0;
    }
}

V1Switch<Headers, Meta>(p(), vrfy(), ingress(), egress(), update(), deparser()) main;