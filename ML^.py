import torch;
torch.set_default_tensor_type(torch.DoubleTensor)
import numpy as np;
from matplotlib import pyplot as plt;
from torch.utils import data;
from torch import nn,tensor;

N=16;
def TARGET(X):
    x=X[0];
    #print("x=",x);
    if(x<N/2):
        ret=x;
    else:
        ret=N-x;
    ret+=100;
    #print("x=",x," ret=",ret);
    return [ret];
class MyDataset(data.Dataset):
    def __init__(self,NOISE=True):
        super(MyDataset, self).__init__()
        self.n=N;
        self.data=np.zeros((2,N,1));
        self.data[0]=(np.linspace(1,N,num=N)[:,np.newaxis]);
        self.data[1]=list(map(TARGET,self.data[0]));
        #print(list(map(TARGET,self.data[0])));
        if(NOISE):
            self.data[1]+=(np.random.rand(N)[:,np.newaxis]);
        #print(self.data);
        self.data=torch.from_numpy(self.data);
    def __len__(self):
        return self.n;
    def __getitem__(self, index):
        #print("index={}".format(index));
        return self.data[0][index],self.data[1][index];

class MyModel(nn.Module):
    def __init__(self):
        super(MyModel,self).__init__();
        self.net=nn.Sequential(
            nn.Linear(1,4),
            nn.Sigmoid(),
            #nn.ReLU(),
            nn.Linear(4,4),
            nn.Sigmoid(),
            #nn.ReLU(),
            #nn.Linear(10,1)
            nn.Linear(4, 1)
        )
    def forward(self,x):
        return self.net(x);

dataset=MyDataset();
tr_set=data.DataLoader(dataset,N,shuffle=True);
for i, (number, label) in enumerate(tr_set):
    print("i={}:(number={},label={}".format(i,number[0],label[0]))
plt.plot(dataset.data[0],dataset.data[1],'.r')

#exit();
model=MyModel().to("cpu");
criterion=nn.MSELoss();
optimizer=torch.optim.SGD(model.parameters(),0.01,momentum=0);
for epoch in range(3000):
    model.train();
    for x,y in tr_set:
        optimizer.zero_grad();
        x,y=x.to("cpu"),y.to("cpu");
        pred=model(x);
        loss=criterion(pred,y);
        loss.backward();
        if(epoch%30==0):
            print("loss=",loss.item())
        optimizer.step();

model.eval();
total_loss=0;
dataset=MyDataset(False);
dv_set=data.DataLoader(dataset,N,shuffle=False);
#print(dv_setx);
#for i, (number, label) in enumerate(dv_set):
    #print("i={}:(number={},label={}".format(i,number,label))
for x,y in dv_set:
    x,y=x.to("cpu"),y.to("cpu");
    with torch.no_grad():
        pred=model(x);
        plt.plot(x,pred,'.b');
        #print("x={} y={} pred={}".format(x,y,pred));
        loss=criterion(pred,y);
    total_loss+=loss.cpu().item()*len(x);
    avgloss=total_loss
plt.show();