pipeline {
    agent any

    /* Uncomment the following block to schedule the Jenkins job for nightly runs to run 7:00 pm every day
    triggers {
        cron ("0 19 * * *")
    }. */
    stages {
        stage('input1') {
            steps {
                git branch: 'main',
                url: 'https://github.com/suprithguk/goodStackAssessment.git'
                sh "python3 -m venv goodStack"

                // Uncomment the following line to run the robot test cases file in Jenkins
                //sh "python3 -m venv goodStack; . ./goodStack/bin/activate; pip3 install -r requirements.txt && python3 -m robot -d test1output ipPrintTestCases.robot --exclude input2"
                dir ("test1output") {

                    sh ". ../goodStack/bin/activate; python3 ../ip_print.py ../input1.json"
                }
            }
        }
        stage('input2') {
            steps {
                sh "python3 -m venv goodStack"

                // Uncomment the following line to run the robot test cases file in Jenkins
                // sh "python3 -m venv goodStack; . ./goodStack/bin/activate; pip3 install -r requirements.txt && python3 -m robot -d test2output ipPrintTestCases.robot --exclude input1"
                dir ("test2output") {
                    sh ". ../goodStack/bin/activate; python3 ../ip_print.py ../input2.json"
                }
            }
        }
    }
    post {
        always {
            echo 'Pipeline execution complete.'
        }
        failure {
            echo 'Pipeline failed.'
        }
        success {
            echo 'Pipeline succeeded.'
        }
    }
}