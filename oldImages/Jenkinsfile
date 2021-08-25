node() {
    try {
        stage("Get repositories") {
            script{
                def pyrdf_docker
                def worker_docker
                def currenttime
                git 'http://localhost:3000/Vetch/RunWIthSecond'
            }
        }
        stage("Build and compile base"){
            script{
                docker.build("root_base", "--network='host' BaseROOT")
            }
        }

        stage("Build images"){
            parallel(
                "command": {
                    stage("Build PyRDF") {
                        script{
                            pyrdf_docker = docker.build("pyrdf_terraform", "--network='host' Worker")
                        }
                    }
                    stage("Pack image to CERNBox") {
                        pyrdf_docker.inside("--network='host' -v /var/run/docker.sock:/var/run/docker.sock -v /mnt/dav:/mnt/dav")
                        {
                            // sh '. /cern_root/root/bin/thisroot.sh && python2 /cern_root/root/PyRDF/introduction.py'
                            // sh 'cd /terraform && terraform init &&  terraform apply -auto-approve && terraform destroy -auto-approve'
                            sh """
                            mkdir -p /mnt/dav/AWS_ROOT
                            cd /mnt/cern_root
                            zip -r /mnt/dav/AWS_ROOT/aws_root.zip chroot root_install
                            """
                        }
                    }
                }
            )
        }
    }
    catch (e) {
        def msg = "`FAILED`\n${env.JOB_NAME}: #${env.BUILD_NUMBER}:\n${env.BUILD_URL} ${e} duration: ${currentBuild.durationString.split('and')[0]}"
        mattermostSend color: 'good', message: msg, text: 'optional for @here mentions and searchable text'
    }
}