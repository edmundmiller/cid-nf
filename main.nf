// import Cid

// Multihash cid = Cid.encode(new File("file.txt"));

process PUBLISH_CID {
    publishDir "results/", mode: "copy", saveAs: { it.digest('SHA-256') + it }
    // TODO saveAs: { it.cid('v1') + it }


    output:
    path "sample.txt", emit: result_file

    script:
    """
    head -c 1M /dev/urandom > sample.txt
    """
}
workflow {
    PUBLISH_CID()
}
