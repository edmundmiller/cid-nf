// import Cid

// Multihash cid = Cid.encode(new File("file.txt"));

process PUBLISH_CID {
    publishDir "${result_file.digest('SHA-256')}/", mode: "copy"

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
