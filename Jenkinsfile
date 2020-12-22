node('haimaxy-jnlp') {
       stage('Clone') {
        echo "1.Clone Stage"
		checkout scm
        script {
            build_tag = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
			if (env.BRANCH_NAME != 'main') {
                build_tag = "${env.BRANCH_NAME}-${build_tag}"
        }
    }
	}
 stage('Build') {
        echo "3.Build Docker Image Stage"
    sh "docker build -t firexuxiaoman/python-demo:${build_tag} ."
    }
    stage('Push') {
        echo "4.Push Docker Image Stage"
        withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
        sh "docker login -u ${dockerHubUser} -p ${dockerHubPassword}"
        sh "docker push firexuxiaoman/python-demo:${build_tag}"
    }
        }
    stage('Deploy') {
        echo 'Deploy Stage'
		if (env.BRANCH_NAME == 'main') {
            input "确认要部署线上环境吗？"
        }
        sh "sed -i 's/<BUILD_TAG>/${build_tag}/' ./k8s/deployment.yaml"
        sh "kubectl apply -f ./k8s/deployment.yaml --record"
        sh "kubectl apply -f ./k8s/ingress.yaml --record"
        sh "kubectl apply -f ./k8s/service.yaml --record"
    }
}
