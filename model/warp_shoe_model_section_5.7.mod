#Victoria_Piroian_piroianv_1006882090 
#Jonah_Ernest_ernestjo_1007065275
#Dina_Aynalem_aynalemd_1006830146

set Product_Num;                                                  # number/id of the shoe type that is being sold
set RM_Num;                                                       # id of the raw materials used to create the shoes
set Machine_Num;                                                  # machine id that is used in the production of shoes
set Warehouse_Num;                                                # warehouse id where products are stored

param Sales_Price{i in Product_Num};                              # sales price per unit for shoe type i in $/unit (r_i)
param Cost{p in RM_Num};                                          # cost for a unit of raw material p in $ (c_p)
param Quantity{i in Product_Num, p in RM_Num} default 0;          # number of units of raw material p used to make shoe i (n_ip)
param OpCost_per_min{j in Machine_Num};                           # operating cost per min of machine j in $/min (m_j)
param Op_Cost{k in Warehouse_Num};                                # monthly operating cost for warehouse k in $/month (w_k)
param Avg_Duration{i in Product_Num, j in Machine_Num} default 0; # time in seconds needed to produce shoe i at machine j (t_ij)
param S_Quantity{p in RM_Num};                                    # max quantity available of raw material p (q_p)
param Product_Demand{i in Product_Num};                           # demand per shoe i (d_i)
param Capacity{k in Warehouse_Num};                               # capacity for each warehouse k (a_k)

# define the decision variables
var x{i in Product_Num};                                          # number of pairs of shoe type i to produce in February of 2006

# define objective function
maximize profit: sum {i in Product_Num} Sales_Price[i]*x[i]                                  # revenue from shoes sold
- sum{i in Product_Num, j in Machine_Num} OpCost_per_min[j]*Avg_Duration[i,j]*x[i]/60        # monthly operating cost of machines
- sum{k in Warehouse_Num} Op_Cost[k]                                                         # monthly warehouse cost
- sum{i in Product_Num, j in Machine_Num} (25/3600)*Avg_Duration[i,j]*x[i]                   # total monthly workers salary
- sum{i in Product_Num, p in RM_Num} Cost[p]*Quantity[i,p]*x[i]                              # raw materials cost
- sum{i in Product_Num} 10*(2*round(Product_Demand[i])-x[i]);                                # cost for falling short of demand


subject to RM_Budget: sum{i in Product_Num, p in RM_Num} Cost[p]*Quantity[i,p]*x[i] <= 17000000;
# constraint for the budget of raw materials
subject to Machine_Work_Time{j in Machine_Num}: sum{i in Product_Num} Avg_Duration[i,j]*x[i] <= 1209600; # constraint on max monthly machine operating time
subject to RM_Limit{p in RM_Num}: sum{i in Product_Num} Quantity[i,p]*x[i] <= S_Quantity[p];             # constraint on max amount of each raw material available
subject to Demand_Limit{i in Product_Num}: x[i] <= 2*round(Product_Demand[i]);                           # constraint that limits the amount of shoe i produced based on teh monthly demand
subject to Warehouse_Capacity: sum{i in Product_Num} x[i] <= sum {k in Warehouse_Num} Capacity[k];       # constraint for max number of shoes all warehouses can store
subject to Non_Neg{i in Product_Num}: x[i] >= 0;                                                         # non negativity constraint
