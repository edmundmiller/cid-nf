import io.ipfs.cid.*

// def gazoduc = gazoduc.Gazoduc.getInstance(params).putGenomeId()
// https://github.com/lindenb/gazoduc-nf/blob/83ca162264de0bbee2e3e2507ad94cd46b873163/workflows/gatk/gatk4gvcfs/gatk4.hapcaller.gvcfs.nf#L26
Cid cid = Cid.decode("zdpuAyvkgEDQm9TenwGkd5eNaosSxjgEYd8QatfPetgB1CdEZ");

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
