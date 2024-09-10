import Cid

// Multihash cid = Cid.encode(new File("file.txt"));

process PUBLISH_CID {
    publishDir "results/", mode: "copy", saveAs: { "ipfs add -n $it".execute().text + it }
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
