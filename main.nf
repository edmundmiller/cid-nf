import io.ipfs.cid.Cid
import io.ipfs.multihash.Multihash

// def gazoduc = gazoduc.Gazoduc.getInstance(params).putGenomeId()
// https://github.com/lindenb/gazoduc-nf/blob/83ca162264de0bbee2e3e2507ad94cd46b873163/workflows/gatk/gatk4gvcfs/gatk4.hapcaller.gvcfs.nf#L26
def exampleCid = Cid.decode("zdpuAyvkgEDQm9TenwGkd5eNaosSxjgEYd8QatfPetgB1CdEZ");
// println exampleCid

process PUBLISH_CID {
    publishDir "results/", mode: "copy", saveAs: { filename ->
        try {
            println filename.getClass()
            def fileContent = filename.getBytes()
            def digest = MessageDigest.getInstance("SHA-256")
            def hash = digest.digest(fileContent)
            def multihash = new Multihash(Multihash.Type.sha2_256, hash)
            def cid = Cid.buildV1(Cid.Codec.Raw, multihash.type, multihash.hash)

            // Log the CID for debugging
            println "Generated CID: ${cid}"

            // Return a filename that includes both the CID and the original filename
            return "${cid}_${filename}"
        } catch (Exception e) {
            // Log any exceptions
            println "Error in saveAs closure: ${e.message}"
            e.printStackTrace()

            // Return the original filename if there's an error
            return filename
        }
    }

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

def createCidFromFile(File file) {
}
