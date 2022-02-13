%PA 5 Harmonic Wave Equation
%Jinseng Vanderkloot 

nx = 50;
ny = 50; 
V = zeros(nx,ny);
G = sparse(nx*ny,ny*nx);

for i = 1:nx
    for j = 1:ny
        
        %Middle and Side nodes 
        n = j + (i-1) * ny;    
        nxm = j + (i-2) * ny;	
        nxp = j + i * ny;       
        nym = (j-1) + (i-1) * ny; 
        nyp = (j+1) + (i-1) * ny; 
        
        %Boundary
        if i == 1 || i == nx || j == 1 || j == ny
            G(n,n) = 1;
        %Center nodes 
        else
            G(n,n) = -4;
            G(n,nxm) = 1;
            G(n,nxp) = 1;
            G(n,nym) = 1;
            G(n,nyp) = 1;
        end
        
        %Add disruption in small area (Different material / Space) 
%          if i > 10 && i < 20 && j > 10 && j < 20
%              G(n,n) = -2;
%          end

    end
end

% Plotting the sparsity of the G Matrix
figure('name', 'G Matrix');
spy(G);

%Eigen Functions
[E, D] = eigs(G, 9, 'SM');

%Plot Eigen Values from Diag of D
figure('name', 'Eigen Values');
plot(diag(D), '*');

%Plot solution surfaces 
figure('name', 'Eigen Values Surfaces')
for k = 1:9
    M = E(:,k);
    for i= 1:nx
        for j= 1:ny
            n=i+(j-1)*nx;
            V(i,j) = M(n);
        end 
    end 
    subplot(3,3,k)
    surf(V)
    title(['Eigen Value = ' num2str(D(k,k))]);
end

%When they are plotted, they show the hranomic components of the wave as
%expected 

%When changing value of nx and ny so they are unequal, the harmonics become 
%complex because the space is no longer symetrical and reflections occur 
%unevenly causing layering (nx = 60, ny=50) 