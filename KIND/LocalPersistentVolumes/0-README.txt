The Local Persistent Volumes feature has been promoted to GA in Kubernetes 1.14. A local persistent volume represents a local disk directly-attached to a single Kubernetes Node.

In the Kubernetes system, local disks can be used through HostPath, LocalVolume.

HostPath: The volume itself does not contain scheduling information. If you want to fix each pod on a node, you need to configure scheduling information, such as nodeSelector, for the pod.

LocalVolume: The volume itself contains scheduling information, and the pods using this volume will be fixed on a specific node, which can ensure data continuity.
Local Persistent Volumes allow you to access local disk by using the standard PVC object.




Create StorageClass with WaitForFirstConsumer Binding Mode
First, a StorageClass should be created that sets volumeBindingMode: WaitForFirstConsumer to enable volume topology-aware scheduling. This mode instructs Kubernetes to wait to bind a PVC until a Pod using it is scheduled.

cat << EOF | kubectl apply -f -
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: local-storage
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer
EOF


Prepare volume on the host
# Execute these commands on the worker node where the POD will be located
mkdir -p /data/volumes/pv1
chmode 777 /data/volumes/pv1
Create Local PersistentVolume
Create PersistentVolume with a reference to local-storage StorageClass

cat << EOF | kubectl apply -f -
apiVersion: v1
kind: PersistentVolume
metadata:
  name: test-local-pv
spec:
  capacity:
    storage: 10Gi
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: local-storage
  local:
    path: /data/volumes/pv1
  nodeAffinity:
    required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          operator: In
          values:
          - k8s-worker-01
EOF
persistentvolume/test-local-pv created

kubectl get pv
NAME            CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS    REASON   AGE
test-local-pv   10Gi       RWO            Retain           Available           local-storage            17s


Create a PersistentVolumeClaim
Create PersistentVolumeClaim with a reference to local-storage StorageClass

cat << EOF | kubectl apply -f -
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: test-pvc
spec:
  accessModes:
  - ReadWriteOnce
  storageClassName: local-storage
  resources:
    requests:
      storage: 10Gi
EOF
persistentvolumeclaim/test-pvc created

kubectl get pvc
NAME       STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS    AGE
test-pvc   Pending                                      local-storage   27s

kubectl get pv
NAME            CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS    REASON   AGE
test-local-pv   10Gi       RWO            Retain           Available           local-storage            33s
The status of test-local-pv is Available because the POD has not yet been created.

Create a POD with local persistent volume


cat << EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: test-local-vol
  labels:
    name: test-local-vol
spec:
  containers:
  - name: app
    image: busybox
    command: ['sh', '-c', 'echo "The local volume is mounted!" > /mnt/test.txt && sleep 3600']
    volumeMounts:
      - name: local-persistent-storage
        mountPath: /mnt
  volumes:
    - name: local-persistent-storage
      persistentVolumeClaim:
        claimName: test-pvc
EOF

pod/test-local-vol created

kubectl get pods
NAME             READY   STATUS    RESTARTS   AGE
test-local-vol   1/1     Running   0          8s
Check the status of PersistentVolume and PersistentVolumeClaim

kubectl get pvc
NAME       STATUS   VOLUME          CAPACITY   ACCESS MODES   STORAGECLASS    AGE
test-pvc   Bound    test-local-pv   10Gi       RWO            local-storage   57s

kubectl get pv
NAME            CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM              STORAGECLASS    REASON   AGE
test-local-pv   10Gi       RWO            Retain           Bound    default/test-pvc   local-storage            104s
You can see the file on the host’s path.

cat /data/volumes/pv1/test.txt
The local volume is mounted!

